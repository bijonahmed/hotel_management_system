<?php

namespace App\Http\Controllers\Report;

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
use App\Models\PurchaseInvoice;
use App\Models\RestInvoice;
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

class ReportController extends Controller
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


    public function filterByRestReport(Request $request)
    {
        //dd($request->all());
        $fromDate     =  $request->fromDate;
        $toDate       =  $request->toDate;
        $invoice_id   =  $request->invoice_id;
        $customer_id  =  $request->customer_id;

        $query = RestInvoice::orderby('id', 'desc');
        // Filter: Only if fromDate and toDate exist
        if ($fromDate && $toDate) {
            $query->whereBetween(\DB::raw('DATE(restaruent_invoice.created_at)'), [$fromDate, $toDate]);
        }
        // Filter by Booking ID
        if ($invoice_id) {
            $query->where('restaruent_invoice.invoice_no', $invoice_id);
        }
        // Filter by Customer ID
        if ($customer_id) {
            $query->where('restaruent_invoice.phone', $customer_id); // or your actual customer/user field
        }
        $invoices = $query->get();
        // Add 'created_by' column to each invoice
        $invoices->transform(function ($invoice) {
            $chkName = User::where('id', $invoice->invoice_create_by)->first();
            $invoice->created_by = !empty($chkName->name) ? $chkName->name : "";
            return $invoice;
        });


        $bookingQuery = Booking::select('id','booking_id','item_total')->where('booking_status', 2)->orderby('id', 'desc');
        if ($fromDate && $toDate) {
            $bookingQuery->whereBetween(\DB::raw('DATE(booking.created_at)'), [$fromDate, $toDate]);
        }
        $bookingData = $bookingQuery->get();

        $data['restData']    = $invoices;
        $data['bookingData'] = $bookingData;
        return response()->json($data, 200);
    }


 public function filterByTransactionReport(Request $request)
    {
        // dd($request->all());
        $fromDate     =  $request->fromDate;
        $toDate       =  $request->toDate;

        $query = PurchaseInvoice::query();
        // Filter: Only if fromDate and toDate exist
        if ($fromDate && $toDate) {
            $query->whereBetween(\DB::raw('DATE(created_at)'), [$fromDate, $toDate]);
        }

        $rdata = $query->get();

        return response()->json($rdata, 200);
    }



    

    public function filterBybookingReport(Request $request)
    {
        // dd($request->all());
        $fromDate     =  $request->fromDate;
        $toDate       =  $request->toDate;
        $booking_id   =  $request->booking_id;
        $customer_id  =  $request->customer_id;
        $status       =  $request->selectedFilter;

        $query = Booking::query()
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
            ->leftJoin('room', 'booking.room_id', '=', 'room.id')
            ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id');

        // Filter: Only if fromDate and toDate exist
        if ($fromDate && $toDate) {
            $query->whereBetween(\DB::raw('DATE(booking.created_at)'), [$fromDate, $toDate]);
        }
        // Filter by Booking ID
        if ($booking_id) {
            $query->where('booking.booking_id', $booking_id);
        }
        // Filter by Customer ID
        if ($customer_id) {
            $query->where('booking.customer_id', $customer_id); // or your actual customer/user field
        }
        // Filter by status
        if ($status) {
            $query->where('booking.booking_status', $status); // change field name if needed
        }

        $bookingData = $query->get();

        return response()->json($bookingData, 200);
    }
}
