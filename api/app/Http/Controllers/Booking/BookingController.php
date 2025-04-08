<?php

namespace App\Http\Controllers\Booking;

use App\Category;
use App\Http\Controllers\Controller;
use App\Models\Attribute;
use App\Models\AttributeValues;
use App\Models\Booking;
use App\Models\Categorys;
use App\Models\MiningCategory;
use App\Models\MiningHistory;
use App\Models\Mystore;
use App\Models\PostCategory;
use App\Models\Product;
use App\Models\ProductAttributes;
use App\Models\ProductAttributeValue;
use App\Models\Room;
use App\Models\RoomImages;
use App\Models\Setting;
use App\Models\SubAttribute;
use App\Models\User;
use App\Rules\MatchOldPassword;
use Auth;
use Carbon\Carbon;
use DB;
use Helper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Validator;

class BookingController extends Controller
{
    protected $userid;
    public function __construct()
    {
        $this->middleware('auth:api'); // Apply the auth middleware

        $user = auth('api')->user();  // Get the user from the token
        if (!$user) {
            return response()->json(['message' => 'Unauthenticated'], 401); // If no user is found, return unauthenticated
        }

        $this->userid = $user->id;
        //dd("User ID: ".$this->userid); // Debugging to see the user ID
    }

   

    public function getBookingDetails(Request $request)
    {
        try {

            $bookingId = $request->id;
            $roomParticular = Booking::where('booking.booking_id', $bookingId)
                ->select(
                    'booking.*',
                    'room.name as room_name',
                    'booking.checkin',
                    'booking.checkout',
                    'room.roomPrice',
                    'room.roomDescription',
                    'bed_type.name as bed_name',
                    \DB::raw('DATEDIFF(booking.checkout, booking.checkin) as total_booking_days')
                )
                ->leftJoin('room', 'booking.room_id', '=', 'room.id') // Fixing bed_type join
                ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id') // Fixing bed_type join
                ->first();
            //dd($roomParticular->room_id);
            $setting = Setting::find(1);

            $room_id          = $roomParticular->room_id;
            $activeRoomImg    = RoomImages::where('status', 1)
                ->where('room_id', $room_id)
                ->get()
                ->map(function ($room) {
                    // Check if roomImage exists and is not empty
                    return [
                        'roomImage' => !empty($room->roomImage) ? url($room->roomImage) : null // Returning null if empty
                    ];
                });

            $data['roomParticular'] = $roomParticular;
            $data['activeRoomImg']  = $activeRoomImg;
            $data['setting'] = $setting;
            /// dd($data);

            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    public function activeBookingRooms(Request $request)
    {

        try {
            $rowsData = Booking::where('booking.customer_id', $this->userid)
                ->where('booking.booking_status', 1)
                ->leftJoin('room', 'room.id', '=', 'booking.room_id')
                ->leftJoinSub(
                    RoomImages::select('room_id', DB::raw('MIN(id) as min_id'))
                        ->groupBy('room_id'),
                    'first_images',
                    'room.id',
                    '=',
                    'first_images.room_id'
                )
                ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id')
                ->select(
                    'room.slug',
                    'room.id',
                    'room.name',
                    'room.roomDescription',
                    'room.roomPrice',
                    'booking.checkin',
                    'booking.checkout',
                    'booking.booking_id',
                    'room_images.roomImage'
                )
                ->get()
                ->map(function ($room) {
                    return [
                        'room_id'         => $room->id,
                        'name'            => $room->name,
                        'slug'            => $room->slug,
                        'booking_id'      => $room->booking_id,
                        'checkin'         => date("d-m-Y", strtotime($room->checkin)),
                        'checkout'        => date("d-m-Y", strtotime($room->checkout)),
                        'roomPrice'       => number_format($room->roomPrice, 2),
                        'roomDescription' => Str::limit($room->roomDescription, 50),
                        'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : "",
                    ];
                });

            return response()->json($rowsData, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function bookingRequest(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make(
            $request->all(),
            [
                'name'      => 'required',
                'slug'      => 'required',
                'email'     => 'required|email',
                'checkin'   => 'required|date',
                'checkout'  => 'required|date|after_or_equal:checkin',
            ],
            [
                'name.required'     => 'Please enter your name.',
                'email.required'    => 'Email address is required.',
                'email.email'       => 'Please provide a valid email address.',
                'checkin.required'  => 'Please select a check-in date.',
                'checkin.date'      => 'Check-in date must be a valid date.',
                'checkout.required' => 'Please select a check-out date.',
                'checkout.date'     => 'Check-out date must be a valid date.',
                'checkout.after_or_equal' => 'Check-out date must be the same or after the check-in date.',
            ]
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $checkSlug = Room::where('slug', $request->slug)->first();
        //echo $checkSlug->id;exit; 

        $existingBooking = Booking::where('room_id', $checkSlug->id)
            ->where(function ($query) use ($request) {
                $query->where(function ($q) use ($request) {
                    $q->where('checkin', '<', $request->checkout)
                        ->where('checkout', '>', $request->checkin);
                });
            })->first();

        if ($existingBooking) {
            $nextAvailableDate = Carbon::parse($existingBooking->checkout)->format('Y-m-d');
            return response()->json([
                'message' => 'Room already booked for selected dates. Please choose a checkout date after ' . $nextAvailableDate,
            ], 409); // 409 Conflict
        }

        // Call the separate method to generate a unique booking ID
        $bookingId = $this->generateUniqueBookingId();

        $data = [
            'booking_id'  => $bookingId,  // Adding custom unique booking ID
            'name'        => $request->name,
            'email'       => $request->email,
            'checkin'     => $request->checkin,
            'checkout'    => $request->checkout,
            'room_id'     => $checkSlug->id,
            'adult'       => $request->adult,
            'child'       => $request->child,
            'message'     => $request->message,
            'customer_id' => $this->userid,
            'booking_status' => 1,
        ];

        Booking::create($data);

        return response()->json(['message' => 'Successfully booked.']);
    }

    // Separate method to generate unique booking ID
    public function generateUniqueBookingId()
    {
        // Generate a random 5-digit number initially
        $bookingId = rand(10000, 99999); // 5-digit number
        // Continue generating until a unique ID is found
        while (Booking::where('booking_id', $bookingId)->exists()) {
            $bookingId = rand(10000, 99999); // Generate a new 5-digit number if it exists
        }
        return $bookingId; // Return the unique booking ID
    }


    public function editUserId(Request $request)
    {
        $id = $this->userid;
        $data = User::find($id);

        $response = [
            'data'     => $data,
            'dataImg'  => !empty($data->image) ? url($data->image) : "",
            'doc_file' => !empty($data->doc_file) ? url($data->doc_file) : "",
            'message'  => 'success'
        ];
        return response()->json($response, 200);
    }
}
