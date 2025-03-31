<?php

namespace App\Http\Controllers\Post;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Auth;
use Validator;
use Helper;
use App\Models\Holiday;
use App\Models\User;
use App\Models\ProductAttributeValue;
use App\Models\ProductVarrientHistory;
use App\Models\Categorys;
use App\Models\ProductAttributes;
use App\Models\ProductCategory;
use App\Models\Product;
use App\Models\ProductAdditionalImg;
use App\Models\ProductVarrient;
use App\Models\AttributeValues;
use App\Models\Post;
use App\Models\PostCategory;
use Illuminate\Support\Str;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;
use Session;
use DB;

class PostController extends Controller
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

    public function update(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make($request->all(), [
            'name'           => 'required',
            'categoryId'     => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('name'))));
        $data = array(
            'name'                       => $request->name,
            'slug'                       => $slug,
            'description_short'          => !empty($request->description_short) ? $request->description_short : "",
            'description_full'           => !empty($request->description_full) ? $request->description_full : "",
            'question'                   => !empty($request->question) ? $request->question : "",
            'answer'                     => !empty($request->answer) ? $request->answer : "",
            'categoryId'                 => !empty($request->categoryId) ? $request->categoryId : "",
            'status'                     => 1, //!empty($request->status) ? $request->status : "",
            'entry_by'                   => $this->userid
        );
        // dd($data);
        if (!empty($request->file('files'))) {
            $files = $request->file('files');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['thumnail_img'] = $file_url;
        }

        $data['id'] = $request->id;

        ///dd($data);
        //Post::create($data);
        $post = Post::find($request->id);
        $post->update($data);
        $resdata['product_id'] = $post->id;
        return response()->json($resdata);
    }

    public function save(Request $request)
    {
        // dd($request->all());
        $validator = Validator::make($request->all(), [
            'name'             => 'required',
            'post_category_id' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->input('name'))));
        $data = array(
            'name'                       => $request->name,
            'slug'                       => $slug,
            'description'                => !empty($request->description) ? $request->description : "",
            'post_category_id'           => !empty($request->post_category_id) ? $request->post_category_id : "",
            'status'                     => !empty($request->status) ? $request->status : "",
            'entry_by'                   => $this->userid
        );
        // dd($data);
        if (!empty($request->file('files'))) {
            $files = $request->file('files');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['thumnail_img'] = $file_url;
        }
        //Post::create($data);

        if (empty($request->id)) {
            $resdata['post_id'] = Post::insertGetId($data);
        } else {
            $resdata = Post::find($request->id);
            $resdata->update($data);
        }
        return response()->json($resdata);
    }

    public function allPostList(Request $request)
    {

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        // dd($selectedFilter);
        $query = Post::orderBy('id', 'desc')
            ->select('posts.*');

        if ($searchQuery !== null) {
            $query->where('posts.name', 'like', '%' . $searchQuery . '%');
        }

        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $pCategory  = PostCategory::where('id', $item->post_category_id)->first();

            return [
                'id'            => $item->id,
                'name'          => substr($item->name, 0, 250),
                'postCategory'  => $pCategory->name,
                'status'        => $item->status == 1 ? 'Active' : "Inactive",
                'created_at'    => date("Y-M-d", strtotime($item->created_at)),
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

    public function postrow(Request $request)
    {
        $id = $request->postId;
        $data = Post::where('posts.id', $id)
            ->select('posts.*', 'post_category.name as category_name')
            ->join('post_category', 'posts.post_category_id', '=', 'post_category.id')
            ->first();
        $responseData['data']      = $data;
        $responseData['images']    = !empty($data->thumnail_img) ? url($data->thumnail_img) : "";
        // dd($responseData);
        return response()->json($responseData);
    }

    public function postCategoryData(Request $request)
    {

        $id =  $request->id;
        $data = Post::where('posts.categoryId', $id)
            ->select('posts.*', 'post_category.name as category_name')
            ->join('post_category', 'posts.categoryId', '=', 'post_category.id')
            ->get();

        $arryData = [];
        foreach ($data as $v) {
            $arryData[] = [
                'id'                         => $v->id,
                'name'                       => $v->name,
                'question'                   => $v->question,
                'answer'                     => $v->answer,
                'description_full'           => strip_tags($v->description_full),
                'images'                     => url($v->thumnail_img),
            ];
        }
        $responseData['data']  = $arryData;
        return response()->json($responseData);
    }
}
