<?php

namespace App\Http\Controllers\Getway;

use App\Category;
use App\Http\Controllers\Controller;
 use App\Mail\BulkEmailMailable;
use App\Models\Setting;
use Illuminate\Support\Facades\Mail;
use Auth;
use BcMath\Number;
use Carbon\Carbon;
use DB;
use Helper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Validator;

class SenSMSController extends Controller
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



    public function sendbulksms(Request $request)
    {
        // dd($request->all());

        $validator = Validator::make(
            $request->all(),
            [
                'phone_number'  => 'required', // Use 'string' instead of 'email' if it's a comma-separated list
                'subject' => 'required',
                'message' => 'required',
            ],
            [
                'phone_number.required'  => 'Recipient phone number are required.',
                'subject.required' => 'Email subject is required.',
                'message.required' => 'Email message is required.',
            ]
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // $emails      = array_map('trim', explode(',', $request->emails));
        // $settingData = Setting::find(1);
        // foreach ($emails as $email) {
        //     if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
        //         Mail::to($email)->send(new BulkEmailMailable($request->subject, $request->message, $settingData));
        //     }
        // }

        return response()->json(['message' => 'SMS sent successfully.']);
    }
}
