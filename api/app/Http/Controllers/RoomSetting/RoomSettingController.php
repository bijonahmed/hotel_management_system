<?php

namespace App\Http\Controllers\RoomSetting;

use App\Http\Controllers\Controller;
use App\Models\BedType;
use App\Models\BookingType;
use App\Models\Categorys;
use App\Models\PromoCode;
use App\Models\Room;
use App\Models\RoomImages;
use App\Models\RoomSize;
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
use Illuminate\Support\Facades\File;

class RoomSettingController extends Controller
{
    protected $userid;
    public function __construct()
    {
        $this->middleware('auth:api');
        $id = auth('api')->user();
        if (!empty($id)) {
            $user = User::find($id->id);
            $this->userid = $user->id;
        }
    }


    public function delteRoomImages(Request $request)
    {
        // dd($request->all());
        try {
            $row = RoomImages::where('id', $request->id)->first();
            if ($row) {

                $imagePath = public_path($row->roomImage);

                if (File::exists($imagePath)) {
                    File::delete($imagePath);
                }
                $row->delete();

                return response()->json([
                    'status' => 'success',
                    'message' => 'Image deleted successfully.',
                ]);
            } else {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Image not found.',
                ]);
            }
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'An error occurred while deleting the image.',
                'error' => $e->getMessage(),
            ]);
        }
    }

    public function roomImagesSave(Request $request)
    {
        // dd($request->all());
        $validator = Validator::make($request->all(), [
            'room_id'      => 'required',
            'roomImage'    => 'required|file|mimes:jpg,jpeg,png|max:2048',
            'status'       => 'required',
        ], [
            'room_id.required'      => 'Please select a room type.',
            'roomImage.required'    => 'Please upload a room image.',
            'roomImage.file'        => 'The uploaded file must be an image.',
            'roomImage.mimes'       => 'Only JPG, JPEG, and PNG images are allowed.',
            'roomImage.max'         => 'The image size must be less than 2MB.',
            'status.required'       => 'Please select the room status.',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $data = array(
            'room_id'                => $request->room_id,
            'roomImgDescription'     => !empty($request->roomImgDescription) ? $request->roomImgDescription : "",
            'status'                 => $request->status,
        );

        if (!empty($request->file('roomImage'))) {
            $files = $request->file('roomImage');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['roomImage'] = $file_url;
        }


        if (empty($request->id)) {
            RoomImages::create($data);
        } else {
            RoomImages::where('id', $request->id)->update($data);
        }

        $response = [
            'message' => 'Successfull insert',
        ];
        return response()->json($response);
    }


    public function promoCodeSave(Request $request)
    {
        //  dd($request->all());
        $rules = [
            'room_id'    => 'required',
            'form_date'  => 'required|date',
            'to_date'    => 'required|date|after:form_date',
            'discount'   => 'required|numeric|min:0',
            'promoCode'  => 'required',
            'status'     => 'required',
        ];

        // Apply unique validation **only when creating a new record**
        if (empty($request->id)) {
            $rules['room_id'] = 'required|unique:promocode,room_id';
            $rules['promoCode'] = 'required|unique:promocode,promoCode';
        }

        $validator = Validator::make($request->all(), $rules, [
            'room_id.required'    => 'The room selection is required.',
            'room_id.unique'      => 'This room is already associated with a promo code.',
            'form_date.required'  => 'The start date is required.',
            'form_date.date'      => 'The start date must be a valid date.',
            'to_date.required'    => 'The end date is required.',
            'to_date.date'        => 'The end date must be a valid date.',
            'to_date.after'       => 'The end date must be after the start date.',
            'discount.required'   => 'The discount field is required.',
            'discount.numeric'    => 'The discount must be a valid number.',
            'discount.min'        => 'The discount cannot be negative.',
            'promoCode.required'  => 'The promo code is required.',
            'promoCode.unique'    => 'This promo code is already in use.',
            'status.required'     => 'The status field is required.',
        ]);

        // Check validation
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = array(
            'room_id'              => $request->room_id,
            'form_date'            => $request->form_date,
            'to_date'              => $request->to_date,
            'discount'             => $request->discount,
            'promoCode'            => $request->promoCode,
            'status'               => $request->status,
        );
        if (empty($request->id)) {
            PromoCode::create($data);
        } else {
            PromoCode::where('id', $request->id)->update($data);
        }

        $response = [
            'message' => 'Successful insert',
        ];
        return response()->json($response);
    }

    public function roomSave(Request $request)
    {
        // dd($request->all());
        $validator = Validator::make(
            $request->all(),
            [
                'roomType'           => 'required',
                'capacity'           => 'required',
                'roomPrice'          => 'required',
                'bedCharge'          => 'required',
                'roomSize'           => 'required',
                'bedNumber'          => 'required',
                'bedType'            => 'required',
                'roomDescription'    => 'required',
                'status'             => 'required',
            ],
            [
                'roomType.required'        => 'Room Type is required.',
                'roomType.unique'          => 'Room Type must be unique.',
                'capacity.required'        => 'Capacity is required.',
                'roomPrice.required'       => 'Room Price is required.',
                'bedCharge.required'       => 'Bed Charge is required.',
                'roomSize.required'        => 'Room Size is required.',
                'bedNumber.required'       => 'Bed Number is required.',
                'bedType.required'         => 'Bed Type is required.',
                'roomDescription.required' => 'Room Description is required.',
                'status.required'          => 'Status is required.',
            ]
        );
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $slug     = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('roomType'))));
        $data = array(
            'name'                      => $request->roomType,
            'roomType'                  => $request->roomType,
            'capacity'                  => $request->capacity,
            'extraCapacity'             => !empty($request->extraCapacity) ? $request->extraCapacity : "",
            'bedCharge'                 => $request->bedCharge,
            'room_size_id'              => $request->roomSize,
            'bedNumber'                 => $request->bedNumber,
            'roomPrice'                 => $request->roomPrice,
            'bed_type_id'               => $request->bedType,
            'roomDescription'           => $request->roomDescription,
            'reserveCondition'          => !empty($request->reserveCondition) ? $request->reserveCondition : "",
            'slug'                      => $slug,
            'status'                    => !empty($request->status) ? $request->status : "",
        );
        if (empty($request->id)) {
            Room::create($data);
        } else {
            Room::where('id', $request->id)->update($data);
        }

        $response = [
            'message' => 'Successfull insert',
        ];
        return response()->json($response);
    }

    public function roomSizeSave(Request $request)
    {

        $validator = Validator::make(
            $request->all(),
            [
                'name'      => 'required|unique:bed_type,name',
                'status'    => 'required',
            ],
            [
                'name'   => 'Name is required',
                'status' => 'Status is required',
            ]
        );
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $slug     = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('name'))));
        $data = array(
            'name'                      => $request->name,
            'slug'                      => $slug,
            'status'                    => !empty($request->status) ? $request->status : "",
        );
        if (empty($request->id)) {
            RoomSize::create($data);
        } else {
            RoomSize::where('id', $request->id)->update($data);
        }

        $response = [
            'message' => 'Successfull insert',
        ];
        return response()->json($response);
    }






    public function bedtypeSave(Request $request)
    {

        $validator = Validator::make(
            $request->all(),
            [
                'name'      => 'required|unique:bed_type,name',
                'status'    => 'required',
            ],
            [
                'name'   => 'Name is required',
                'status' => 'Status is required',
            ]
        );
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $slug     = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('name'))));
        $data = array(
            'name'                      => $request->name,
            'slug'                      => $slug,
            'status'                    => !empty($request->status) ? $request->status : "",
        );
        if (empty($request->id)) {
            BedType::create($data);
        } else {
            BedType::where('id', $request->id)->update($data);
        }

        $response = [
            'message' => 'Successfully insert',
        ];
        return response()->json($response);
    }



    public function bookingTypeSave(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'name'      => 'required|unique:booking_type,name',
                'status'    => 'required',
            ],
            [
                'name'   => 'Name is required',
                'status' => 'Status is required',
            ]
        );
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $slug     = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('name'))));
        $data = array(
            'name'                      => $request->name,
            'slug'                      => $slug,
            'status'                    => !empty($request->status) ? $request->status : "",
        );

        if (empty($request->id)) {
            BookingType::create($data);
        } else {
            BookingType::where('id', $request->id)->update($data);
        }

        $response = [
            'message' => 'Successfully insert',
        ];
        return response()->json($response);
    }


    public function checkBedTypeRow(Request $request)
    {
        try {
            $id   = $request->id ?? "";
            $data = BedType::where('id', $id)->first();
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function checkRoomRow(Request $request)
    {
        try {
            $id   = $request->id ?? "";
            $data = Room::where('id', $id)->first();
            $data['roomSize'] = $data->room_size_id;
            $data['bedType']  = $data->bed_type_id;
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }



    public function checkRoomSizeRow(Request $request)
    {
        try {
            $id   = $request->id ?? "";
            $data = RoomSize::where('id', $id)->first();
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    public function checkPromoCodeRow(Request $request)
    {
        try {
            $id   = $request->id ?? "";
            $data = PromoCode::where('id', $id)->first();
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    public function checkBookingTypeRow(Request $request)
    {
        try {
            $id   = $request->id ?? "";
            $data = BookingType::where('id', $id)->first();
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    public function findCategoryRow($id)
    {
        $data = Categorys::find($id);
        $response = [
            'data'          => $data,
            'file'          => url($data->file),
            'bg_images'     => url($data->bg_images),
            'store_images'  => url($data->store_images),
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }



    public function roomList(Request $request)
    {
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);
        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = Room::orderBy('id', 'desc');

        if ($searchQuery !== null) {
            $query->where('name', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {

            $query->where('status', $selectedFilter);
        }
        // $query->whereNotIn('users.role_id', [2]);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {
            return [
                'id'            => $item->id,
                'name'          => $item->name,
                'roomType'      => $item->roomType,
                'roomPrice'     => $item->roomPrice,
                'bedCharge'     => $item->bedCharge,
                'bedNumber'     => $item->bedNumber,
                'capacity'      => $item->capacity,
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



    public function promocodeList(Request $request)
    {


        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);
        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = PromoCode::orderBy('id', 'desc');

        if ($searchQuery !== null) {
            $query->where('promoCode', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {

            $query->where('status', $selectedFilter);
        }
        // $query->whereNotIn('users.role_id', [2]);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {
            $chkroom = Room::where('id', $item->room_id)->first();

            $fdate   = date("y-m-d", strtotime($item->form_date));
            $tdate   = date("y-m-d", strtotime($item->to_date));
            $current = date("y-m-d");

            // Determine promo status
            $prostatus = ($tdate < $current) ? 'Expired' : 'Active';


            return [
                'id'            => $item->id,
                'roomType'      => !empty($chkroom->name) ? $chkroom->name : "",
                'promoCode'     => $item->promoCode,
                'form_date'     => $item->form_date,
                'to_date'       => $item->to_date,
                'discount'      => $item->discount,
                'prostatus'     => $prostatus,
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


    public function roomSizeList(Request $request)
    {
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);
        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = RoomSize::orderBy('id', 'desc');

        if ($searchQuery !== null) {
            $query->where('name', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {

            $query->where('status', $selectedFilter);
        }
        // $query->whereNotIn('users.role_id', [2]);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {
            return [
                'id'            => $item->id,
                'name'          => $item->name,
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

    public function getsRoomSize()
    {
        try {
            $data = RoomSize::where('status', 1)->select('id', 'name')->get();

            if ($data->isEmpty()) {
                return response()->json(['message' => 'No room sizes found'], 404);
            }
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }




    public function getsRoomTypes()
    {
        try {
            $data = Room::where('status', 1)->get();

            if ($data->isEmpty()) {
                return response()->json(['message' => 'No room sizes found'], 404);
            }
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }



    public function getsRoomImages()
    {
        try {
            $allImages = RoomImages::where('status', 1)->get();

            $data = [];
            foreach ($allImages as $key => $v) {
                $chkRoomType = Room::where('id', $v->room_id)->first();
                $data[] = [
                    'id'        => $v->id,
                    'roomType' => !empty($chkRoomType) ? $chkRoomType->roomType : "",
                    'roomImage' => !empty($v->roomImage) ? url($v->roomImage) : ""
                ];
            }

            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function getsBetType()
    {
        try {
            $data = BedType::where('status', 1)->select('id', 'name')->get();

            if ($data->isEmpty()) {
                return response()->json(['message' => 'No room sizes found'], 404);
            }
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }




    public function bedtypelist(Request $request)
    {

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);
        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = BedType::orderBy('id', 'desc');

        if ($searchQuery !== null) {
            $query->where('name', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {

            $query->where('status', $selectedFilter);
        }
        // $query->whereNotIn('users.role_id', [2]);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {
            return [
                'id'            => $item->id,
                'name'          => $item->name,
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

    public function bookingTypeList(Request $request)
    {

        $page       = $request->input('page', 1);
        $pageSize   = $request->input('pageSize', 10);
        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = BookingType::orderBy('id', 'desc');

        if ($searchQuery !== null) {
            $query->where('name', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {

            $query->where('status', $selectedFilter);
        }
        // $query->whereNotIn('users.role_id', [2]);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {
            return [
                'id'            => $item->id,
                'name'          => $item->name,
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
}
