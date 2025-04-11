<?php

namespace App\Http\Controllers\Public;

use Cart;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Room;
use App\Models\RoomImages;
use App\Models\SelectedRoomFacility;
use App\Models\Setting;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Log;
use Validator;
use Illuminate\Support\Facades\DB;

class PublicController extends Controller
{


    public function filterBooking(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make(
            $request->all(),
            [
                'check_in'  => 'required|date',
                'check_out' => 'required|date|after_or_equal:check_in',
            ],
            [
                'check_in.required' => 'The check-in date is required.',
                'check_in.date'     => 'The check-in must be a valid date.',
                'check_out.required' => 'The check-out date is required.',
                'check_out.date'     => 'The check-out must be a valid date.',
                'check_out.after_or_equal' => 'The check-out date must be after or equal to the check-in date.',
            ]
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }


        // Fetch available rooms (booking_status = 2 or NULL)
        $rooms = Room::where('booking_status', 2)
            ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id') // Fixing bed_type join
            ->leftJoinSub(
                \DB::table('room_images')
                    ->select('room_id', \DB::raw('MIN(id) as min_id')) // Get first image ID
                    ->groupBy('room_id'),
                'first_images',
                'room.id',
                '=',
                'first_images.room_id'
            )
            ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id') // Join first image
            ->orWhereNull('booking_status')
            ->select('room.slug', 'room.id', 'room.name', 'room.roomDescription', 'bed_type.name as bed_name', 'roomPrice', 'room_images.roomImage')
            ->get()
            ->map(function ($room) {
                return [
                    'room_id'         => $room->id,
                    'name'            => $room->name,
                    'slug'            => $room->slug,
                    'bed_name'        => $room->bed_name,
                    'roomPrice'       => number_format($room->roomPrice, 2),
                    'roomDescription' =>  Str::limit($room->roomDescription, 50), // Limit to 50 characters,
                    'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                ];
            });



        return response()->json([
            'message' => 'Available rooms fetched successfully.',
            'rooms' => $rooms
        ], 200);
    }



    public function activeRooms(Request $request)
    {
        try {

            $rowsData = Room::where('room.status', 1)
                ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id') // Fixing bed_type join
                ->leftJoinSub(
                    \DB::table('room_images')
                        ->select('room_id', \DB::raw('MIN(id) as min_id')) // Get first image ID
                        ->groupBy('room_id'),
                    'first_images',
                    'room.id',
                    '=',
                    'first_images.room_id'
                )
                ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id') // Join first image
                ->select('room.slug', 'room.id', 'room.name', 'room.roomDescription', 'bed_type.name as bed_name', 'roomPrice', 'room_images.roomImage')
                ->get()
                ->map(function ($room) {
                    return [
                        'room_id'         => $room->id,
                        'name'            => $room->name,
                        'slug'            => $room->slug,
                        'bed_name'        => $room->bed_name,
                        'roomPrice'       => number_format($room->roomPrice, 2),
                        'roomDescription' =>  Str::limit($room->roomDescription, 50), // Limit to 50 characters,
                        'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                    ];
                });
            return response()->json($rowsData, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }



    public function getRoomDetails(Request $request)
    {

        try {

            $roomParticular = Room::where('room.status', 1)->where('room.slug', $request->slug)
                ->select('room.*', 'bed_type.name as bed_name')
                ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id') // Fixing bed_type join
                ->first();

            $room_id          = $roomParticular->id;
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

            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function checkselectedfacilities(Request $request)
    {

        try {
            $data = SelectedRoomFacility::where('room_id', $request->id)
                ->select('select_room_facilities.id', 'facility_group.name as facility_group_name', 'room.roomType as room_name', 'room_facility.name as facilities_name')
                ->leftJoin('facility_group', 'facility_group.id', '=', 'select_room_facilities.room_facility_group_id')
                ->leftJoin('room', 'room.id', '=', 'select_room_facilities.room_id')
                ->leftJoin('room_facility', 'room_facility.id', '=', 'select_room_facilities.facilities_id')
                ->orderby('id', 'desc')
                ->get();
            if ($data->isEmpty()) {
                return response()->json(['message' => 'No room sizes found'], 404);
            }
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function getGlobalData()
    {

        try {
            $data = Setting::where('id', 1)->first();
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function sendContact(Request $request)
    {

        // dd($request->all());
        $validator = Validator::make($request->all(), [
            'name'             => 'required',
            'email'            => 'required',
            'subject'          => 'required',
            'message'          => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        //Please add email qeue...

        return response()->json("Send mail", 200);
    }
}
