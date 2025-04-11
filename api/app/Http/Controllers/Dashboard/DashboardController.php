<?php

namespace App\Http\Controllers\Dashboard;

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
use BcMath\Number;
use Carbon\Carbon;
use DB;
use Helper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Validator;

class DashboardController extends Controller
{
    protected $userid;
    public function __construct()
    {
        $this->middleware('auth:api');
        $user = auth('api')->user();
        if (!$user) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }
        $this->userid = $user->id;
    }



    public function countBookingData(Request $request)
    {
        try {

            $checkToday       = date("Y-m-d");
            $customerRuleId   = 2;
            $todayBookingData = Booking::where('booking.booking_status', 1)->whereDate('booking.created_at', $checkToday)->count();
            $bookingPayment   = Booking::where('booking.booking_status', 1)->whereDate('booking.created_at', $checkToday)->whereIn('paymenttype', [1, 2])->sum('room_price');
            $customerCount    = User::where('users.status', 1)->where('users.role_id', $customerRuleId)->count();
            $roomCount        = Room::where('room.status', 1)->count();

            // Prepare data
            $data = [
                'todayBooking'   => $todayBookingData,
                'bookingPayment' => number_format($bookingPayment, 2),
                'customerCount'  => $customerCount,
                'roomCount'      => $roomCount,
            ];

            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    public function getTodayBookingList()
    {

        $bookingData = Booking::where('booking.booking_status', 1)
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
            ->get();
       
        return response()->json($bookingData, 200);
    }
}
