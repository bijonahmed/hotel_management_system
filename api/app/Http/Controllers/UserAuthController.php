<?php

namespace App\Http\Controllers;

use DB;
use Validator;
use App\Models\User;
use App\Models\Setting;
use App\Models\ApiConfig;
use App\Models\MakePlayers;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserAuthController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'userRegister','register', 'showProfileData', 'updateprofile', 'updatePassword']]);
    }
    protected function validateLogin(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);
    }
    public function login(Request $request)
    {
        // dd($request->all());

        $this->validateLogin($request);
        $credentials = request(['username', 'password']);
        if (!$token = auth('api')->attempt($credentials)) {
            return response()->json([
                'errors' => [
                    'account' => [
                        "Invalid username or password"
                    ]
                ]
            ], 422);
        }
        return $this->respondWithToken($token);
    }

    public function userRegister(Request $request)
    {
     //  dd($request->all());
        $setting = Setting::find(1);

        $this->validate($request, [
            'name'        => 'required',
            'email'       => 'required|unique:users,email',
            'username'    => 'required|unique:users,username',
            'password'    => 'required|min:6|confirmed',
            // 'password'   => 'required|min:6'
        ]);

        $inviteCode       = $request->input('inviteCode');
        $user             = User::where('inviteCode', $inviteCode)->first();
        //$this->checkMlmComission($inviteCode);
        $user = User::create([
            'name'                => $request->name,
            'email'               => $request->email,
            'role_id'             => 2,
            'available_balance'   => !empty($setting->register_bonus) ? $setting->register_bonus : 0, // 3 UIC
            'ref_id'              => !empty($user->id) ? $user->id : "",
            'status'              => 1,
            'username'            => $request->username,
            'register_ip'         => $request->ip(),
            'inviteCode'          => $this->generateUniqueRandomNumber(),
            'show_password'       => $request->password,
            'password'            => bcrypt($request->password),
        ]);

        $lastInsertedId           = $user->id;
        $inviteCode               = $this->generateUniqueRandomNumber();
        $fg                       = 'FG' . sprintf('%09d', $user->id);
        $user->update([
            'inviteCode'       => $inviteCode,
            'fg_id'            => $fg, // Add other fields and their respective values here
            'fg_wallet_address' => md5($fg),
            // Add more fields as needed
        ]);

        
        // Get the token
        $token = auth('api')->login($user);
        //echo $token;exit; 
        //$this->makePlayer($request->username, $request->password, $lastInsertedId);

       // echo $token;exit; 
        return $this->respondWithToken($token);
    }
    public function register(Request $request)
    {

        // dd($request->all());
        $setting = Setting::find(1);

        $this->validate($request, [
            'name'        => 'required',
            'email'       => 'required|unique:users,email',
            'username'    => 'required|unique:users,username',
            'password'    => 'required|min:6|confirmed',
            // 'password'   => 'required|min:6'
        ]);

        $inviteCode       = $request->input('inviteCode');
        $user             = User::where('inviteCode', $inviteCode)->first();
        //$this->checkMlmComission($inviteCode);
        $user = User::create([
            'name'                => $request->name,
            'email'               => $request->email,
            'role_id'             => 2,
            'available_balance'   => !empty($setting->register_bonus) ? $setting->register_bonus : 0, // 3 UIC
            'ref_id'              => !empty($user->id) ? $user->id : "",
            'status'              => 1,
            'username'            => $request->username,
            'register_ip'         => $request->ip(),
            'inviteCode'          => $this->generateUniqueRandomNumber(),
            'show_password'       => $request->password,
            'password'            => bcrypt($request->password),
        ]);

        $lastInsertedId           = $user->id;
        $inviteCode               = $this->generateUniqueRandomNumber();
        $fg                       = 'FG' . sprintf('%09d', $user->id);
        $user->update([
            'inviteCode'       => $inviteCode,
            'fg_id'            => $fg, // Add other fields and their respective values here
            'fg_wallet_address' => md5($fg),
            // Add more fields as needed
        ]);
        // Get the token
        $token = auth('api')->login($user);
        $this->makePlayer($request->username, $request->password, $lastInsertedId);

        return $this->respondWithToken($token);
    }


    public function generateUniqueRandomNumber()
    {
        $microtime = microtime(true); // Get the current microtime as a float
        $microtimeString = str_replace('.', '', (string)$microtime); // Remove the dot from microtime
        // Extract the last 5 digits
        $uniqueId = substr($microtimeString, -7);
        return $uniqueId; // Since we're generating only one number, return the first (and only) element of the array
    }


    public function me()
    {
        return response()->json($this->guard('api')->user());
    }
    public function logout()
    {
        auth()->guard('api')->logout();
        return response()->json(['message' => 'Successfully logged out']);
    }
    public function refresh()
    {
        return $this->respondWithToken($this->guard('api')->refresh());
    }


		protected function respondWithToken($token)
	{
		$user = auth('api')->user();
		return response()->json([
			'success' => true, // Indicating success
			'status'  => 200, // Indicating success
			'access_token' => $token,
			'token_type' => 'bearer',
			'expires_in' => auth('api')->factory()->getTTL() * 60,
			'user' => $user
		], 200); // Explicitly set HTTP status 200
	}

    public function guard()
    {
        return Auth::guard();
    }
    public function profile(Request $request)
    {
        $user = auth('api')->user();
        $this->validate($request, [
            'name' => 'required',
            'email' => "required|unique:users,email, $user->id",
            'password' => 'sometimes|nullable|min:8'
        ]);
        $user->update([
            'name' => $request->name,
            'email' => $request->email,
        ]);
        if ($request->password) {
            $user->update([
                'password' => bcrypt($request->password),
            ]);
        }
        return response()->json([
            'success' => true,
            'user' => $user
        ], 200);
    }
    public function updateprofile(Request $request)
    {
        $user = auth('api')->user();
        $authId = $user->id;
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required',
            'phone_number' => 'required',
            'address' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = array(
            'id'                => $authId,
            'name'              => !empty($request->name) ? $request->name : "",
            'email'             => !empty($request->email) ? $request->email : "",
            'phone_number'      => !empty($request->phone_number) ? $request->phone_number : "",
            'address'           => !empty($request->address) ? $request->address : "",
            'website'           => !empty($request->website) ? $request->website : "",
            'github'            => !empty($request->github) ? $request->github : "",
            'twitter'           => !empty($request->twitter) ? $request->twitter : "",
            'instagram'         => !empty($request->instagram) ? $request->instagram : "",
            'facebook'          => !empty($request->facebook) ? $request->facebook : "",
        );
        if (!empty($request->file('file'))) {
            $documents = $request->file('file');
            $fileName = Str::random(20);
            $ext = strtolower($documents->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $documents->move(public_path('/backend/files/'), $upload_url);
            $data['image'] = $upload_url;
        }
        //dd($data);
        DB::table('users')->where('id', $authId)->update($data);
        $response = [
            'imagelink' => !empty($user) ? url($user->image) : "",
            'message' => 'User successfully update'
        ];
        return response()->json($response);
    }
    public function showProfileData(Request $request)
    {
        $data = auth('api')->user();
        return response()->json([
            'data' => $data,
            'dataImg' => !empty($data->image) ? url($data->image) : "",
            'message' => 'User Profile Data'
        ]);
    }
    public function changesPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'password' => 'required|min:1|confirmed',
            'password_confirmation' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $id = auth('api')->user();
        $user = User::find($id->id);
        //dd($currentuser->username);
        $user->password = Hash::make($request->password);
        $user->show_password = $request->password;
        $user->save();
        $response = "Password successfully changed!";
        return response()->json($response);
    }
}
