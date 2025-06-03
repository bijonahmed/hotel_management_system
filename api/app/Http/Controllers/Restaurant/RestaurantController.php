<?php

namespace App\Http\Controllers\Restaurant;

use App\Category;
use App\Http\Controllers\Controller;
use App\Models\Attribute;
use App\Models\AttributeValues;
use App\Models\Booking;
use App\Models\Categorys;
use App\Models\InvoiceItem;
use App\Models\MiningCategory;
use App\Models\MiningHistory;
use App\Models\Mystore;
use App\Models\PostCategory;
use App\Models\Product;
use App\Models\ProductAttributes;
use App\Models\ProductAttributeValue;
use App\Models\RestInvoice;
use App\Models\RestInvoiceHistory;
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
use PayPal\Api\Invoice;
use Validator;

class RestaurantController extends Controller
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


    public function insertItems(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make($request->all(), [
            'name'                  => 'required',
            'email'                 => 'required|email',
            'phone'                 => 'required|digits:11|numeric',
            'address'               => 'required',
            'item_total'            => 'required',
            'advance_amount'        => 'required',
            'due_amount'            => 'required',
            'discount_amount'       => 'required',
            'after_discount'        => 'required',
            'tax_percentage'        => 'required',
            'tax_amount'            => 'required',
            'grand_total'           => 'required',
            'items'                 => 'required|array',
            'items.*.item_id'       => 'required|integer',
            'items.*.name'          => 'required|string',
            'items.*.qty'           => 'required|numeric',
            'items.*.price'         => 'required|numeric',
            'items.*.total'         => 'required|numeric',
        ], [
            'name.required'             => 'Customer name is required.',
            'email.required'            => 'Email address is required.',
            'phone.required'            => 'Phone number is required. Do not include country code. Example: 019xxxxxxxx',
            'phone.digits'              => 'Phone number must be exactly 11 digits. Example: 019xxxxxxxx',
            'address.required'          => 'Address is required.',
            'item_total.required'       => 'Item total is required.',
            'advance_amount.required'   => 'Advance amount is required.',
            'due_amount.required'       => 'Due amount is required.',
            'discount_amount.required'  => 'Discount amount is required.',
            'after_discount.required'   => 'Amount after discount is required.',
            'tax_percentage.required'   => 'Tax percentage is required.',
            'tax_amount.required'       => 'Tax amount is required.',
            'grand_total.required'      => 'Grand total is required.',
            'items.required'            => 'At least one item is required.',
            'items.array'               => 'Items must be in array format.',
            'items.*.item_id.required'  => 'Item ID is required.',
            'items.*.item_id.integer'   => 'Item ID must be an integer.',
            'items.*.name.required'     => 'Item name is required.',
            'items.*.name.string'       => 'Item name must be a string.',
            'items.*.qty.required'      => 'Item quantity is required.',
            'items.*.qty.numeric'       => 'Item quantity must be a number.',
            'items.*.price.required'    => 'Item price is required.',
            'items.*.price.numeric'     => 'Item price must be a number.',
            'items.*.total.required'    => 'Item total is required.',
            'items.*.total.numeric'     => 'Item total must be a number.',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $resData = [
            'invoice_no'        => $this->generateUniqueRandomNumber(),
            'name'              => $request->name,
            'email'             => $request->email,
            'phone'             => $request->phone,
            'address'           => $request->address,
            'item_total'        => str_replace(',', '', $request->item_total),
            'advance_amount'    => str_replace(',', '', $request->advance_amount),
            'due_amount'        => str_replace(',', '', $request->due_amount),
            'discount_amount'   => str_replace(',', '', $request->discount_amount),
            'after_discount'    => str_replace(',', '', $request->after_discount),
            'tax_percentage'    => str_replace(',', '', $request->tax_percentage),
            'tax_amount'        => str_replace(',', '', $request->tax_amount),
            'grand_total'       => str_replace(',', '', $request->grand_total),
            'invoice_create_by'  => $this->userid,
        ];
        $restInvoice = RestInvoice::create($resData);
        // Get the last inserted ID
        $lastId = $restInvoice->id;


        //dd($updateBooking);

        // ✅ Use validated data
        $data = $validator->validated();
        // dd($data);

        foreach ($data['items'] as $item) {
            RestInvoiceHistory::create([
                'rest_invoice_id'   => $lastId,
                'item_id'           => $item['item_id'],
                'name'              => $item['name'],
                'qty'               => $item['qty'],
                'price'             => $item['price'],
                'total'             => $item['total'],
                'invoice_create_by' => $this->userid,
            ]);
        }

        return response()->json(['message' => 'Successfully booked.']);
    }

    public function checkRestInvoiceRow(Request $request)
    {

        //dd($request->all());
        $id     = $request->id;
        $particularData  = RestInvoice::where('restaruent_invoice.id', $id)->first();

        $invoiceItems = RestInvoiceHistory::where('rest_invoice_id', $id)->get();
        $invArray = [];
        foreach ($invoiceItems as $item) {
            $invArray[] = [
                'invoice_no'        => $item->invoice_no,
                'id'                => $item->item_id,
                'name'              => $item->name,
                'qty'               => $item->qty,
                'price'             => $item->price,
                'total'             => $item->total,
                'invoice_create_by' => $item->invoice_create_by,
            ];
        }

        $setting       = Setting::where('id', 1)->first();
        $taxPercentage = !empty($setting->tax_percentag) ? $setting->tax_percentag : "0";

        $data['booking_data']   = $particularData;
        $data['tax_percentage'] = $taxPercentage;
        $data['itemlist']       = $invArray;
        return response()->json($data, 200);
    }

    public function getInvoiceList(Request $request)
    {
        //dd($request->all());
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = RestInvoice::orderBy('id', 'desc');

        if ($searchQuery !== null) {
            $query->where(function ($q) use ($searchQuery) {
                $q->where('restaruent_invoice.phone', 'like', '%' . $searchQuery . '%')
                    ->orWhere('restaruent_invoice.name', 'like', '%' . $searchQuery . '%')
                    ->orWhere('restaruent_invoice.email', 'like', '%' . $searchQuery . '%')
                    ->orWhere('restaruent_invoice.invoice_no', 'like', '%' . $searchQuery . '%');
            });
        }


        // $query->whereNotIn('users.role_id', [2]);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {
            return [
                'id'            => $item->id,
                'invoice_no'    => $item->invoice_no,
                'name'          => $item->name,
                'phone'         => $item->phone,
                'email'         => $item->email,
                'created_at'    => date("Y-M-d H:i:s", strtotime($item->created_at)),
                'updated_at'    => date("Y-M-d H:i:s", strtotime($item->updated_at)),
                'status'        => $item->status == 1 ? 'Active' : 'Inactive',
            ];
        });
        // Return the modified collection along with pagination metadata
        return response()->json([
            'data' => $modifiedCollection,
            'current_page' => $paginator->currentPage(),
            'total_pages' => $paginator->lastPage(),
            'total_records' => $paginator->total(),
        ], 200);
    }

    public function generateUniqueRandomNumber()
    {

        $lastInvoice = \App\Models\RestInvoice::orderBy('id', 'desc')->first();
        $nextId = $lastInvoice ? $lastInvoice->id + 1 : 1;
        // Pad with leading zeros (e.g., 00001)
        return str_pad($nextId, 7, '0', STR_PAD_LEFT);
    }
}
