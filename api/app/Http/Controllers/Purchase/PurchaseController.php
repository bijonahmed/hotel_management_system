<?php

namespace App\Http\Controllers\Purchase;

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
use App\Models\PurchaseHistory;
use App\Models\PurchaseInvoice;
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

class PurchaseController extends Controller
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
        // dd($request->all());
        $validator = Validator::make($request->all(), [
            'name'                  => 'required',
            // 'email'                 => 'required|email',
            'phone'                 => 'required',
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
            'items.*.name'          => 'required',
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
        $purInvoice = PurchaseInvoice::create($resData);
        // Get the last inserted ID
        $lastId = $purInvoice->id;
        // ✅ Use validated data
        $data = $validator->validated();
        // dd($data);

        foreach ($data['items'] as $item) {
            PurchaseHistory::create([
                'purchase_invoice_id' => $lastId,
                'name'              => $item['name'],
                'qty'               => $item['qty'],
                'price'             => $item['price'],
                'total'             => $item['total'],
                'invoice_create_by' => $this->userid,
            ]);
        }
        $data['invoiceid'] = $lastId;
        $data['message']   = 'Successfully insert.';

        return response()->json($data);
    }

    public function editItems(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make($request->all(), [
            'id'                    => 'required',
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

        ], [
            'id.required'               => 'ID number is required.',
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
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $id = $request->id;
        $resData = [
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
            'invoice_create_by' => $this->userid,
        ];

        PurchaseInvoice::where('id', $id)->update($resData);

        // $data['items'] = $request->input('items');
        // dd($data['items']);

        if (!empty($id)) {
            $purchase_invoice_id = $id;
            $getItemHistory = PurchaseHistory::where('purchase_invoice_id', $purchase_invoice_id)->get();
            if ($getItemHistory->isNotEmpty()) {
                // Delete all matching histories
                PurchaseHistory::where('purchase_invoice_id', $purchase_invoice_id)->delete();
                $data['items'] = $request->input('items');
                foreach ($data['items'] as $item) {
                    PurchaseHistory::create([
                        'purchase_invoice_id' => $purchase_invoice_id,
                        'name'                => $item['name'],
                        'qty'                 => $item['qty'],
                        'price'               => $item['price'],
                        'total'               => $item['total'],
                        'invoice_create_by'    => $this->userid,
                    ]);
                }
            }
        }
        return response()->json(['message' => 'Successfully update.']);
    }

    public function checkInvoiceRow(Request $request)
    {
        //dd($request->all());
        $id     = $request->id;
        $particularData  = PurchaseInvoice::where('id', $id)->first();

        $invoiceItems = PurchaseHistory::where('purchase_invoice_id', $id)->get();
        $invArray = [];
        foreach ($invoiceItems as $item) {
            $invArray[] = [
                'purchase_invoice_id' => $item->purchase_invoice_id,
                'id'                => $item->id,
                'name'              => $item->name,
                'qty'               => $item->qty,
                'price'             => $item->price,
                'total'             => $item->total,
                'invoice_create_by' => $item->invoice_create_by,
            ];
        }

        $setting       = Setting::where('id', 1)->first();
        $taxPercentage = !empty($setting->tax_percentag) ? $setting->tax_percentag : "0";

        $data['particularData']   = $particularData;
        $data['tax_percentage'] = $taxPercentage;
        $data['itemlist']       = $invArray;
        return response()->json($data, 200);
    }

    public function deleteInvItem(Request $request)
    {
        //dd($request->all());
        $invoiceId  = $request->invoiceId;
        $item_id    = $request->id;
        //echo "purchase_invoice_id: $invoiceId------------------id: $item_id";
        $item       = PurchaseHistory::where('purchase_invoice_id', $invoiceId)->where('id', $item_id)->first();
        if ($item) {
            $item->delete();
            return response()->json([
                'success' => true,
                'message' => 'Item deleted successfully.',
            ], 200);
        }

        return response()->json([
            'success' => false,
            'message' => 'Item not found.',
        ], 404);
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
        $query = PurchaseInvoice::orderBy('id', 'desc');

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

    public function getOnlyCustomerList(Request $request)
    {
        $data = RestInvoice::groupBy('name')->get();

        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }

    public function generateUniqueRandomNumber()
    {

        $lastInvoice = \App\Models\PurchaseInvoice::orderBy('id', 'desc')->first();
        $nextId = $lastInvoice ? $lastInvoice->id + 1 : 1;
        // Pad with leading zeros (e.g., 00001)
        return str_pad($nextId, 7, '0', STR_PAD_LEFT);
    }
}
