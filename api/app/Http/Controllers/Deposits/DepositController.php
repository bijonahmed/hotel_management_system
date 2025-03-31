<?php

namespace App\Http\Controllers\Deposits;

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
use App\Models\Deposit;
use App\Models\MiningServicesBuyHistory;
use App\Models\Setting;
use App\Models\TransactionHistory;
use App\Models\WalletAddress;
use App\Models\Withdraw;
use App\Models\addWithDrawMethod;
use App\Models\ApiKey;
use App\Models\BulkAddress;
use App\Models\LoanPayHistory;
use App\Models\SendReceived;
use App\Models\UserPaymentAddress;
use App\Models\WithdrawMethod;
use Illuminate\Support\Str;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\JsonResponse;
use Session;
use Carbon\Carbon;
use DB;
use PDO;
use PhpParser\Node\Stmt\TryCatch;

class DepositController extends Controller
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


    public function updateDepositStatus(Request $request)
    {

        //dd($request->all());
        $validator = Validator::make($request->all(), [
            'status'      => 'required',
        ], [
            'status.required'      => 'The status field is required.',
        ]);
        $data = array(
            'status'               => $request->status,
        );
        $resdata['id']             = Deposit::where('id', $request->id)->update($data);
        return response()->json("Successfully update", 200); // Return the result as JSON
        
    }


    public function depositrowCheck(Request $request)
    {
        $id       = $request->id;
        $history  = Deposit::where('id', $id)->first();
        return response()->json($history, 200); // Return the result as JSON


    }


    public function getDepositReport(Request $request)
    {
        // dd($request->all());
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 100);

        // Get search query from the request
        $searchQuery      = $request->searchQuery;
        $searchDepositId  = $request->searchQueryDepositid;
        $selectedFilter   = $request->selectedFilter;
        $searchMerchant   = (int)$request->searchMerchant;

        if (!empty($request->datevalue)) {
            $dateFilter       = date("Y-m-d", strtotime($request->datevalue));
        } else {
            $dateFilter       = date("Y-m-d");
        }


        if ($searchMerchant === 0) {
            $searchMerchant = null; // or use '' (empty string) if you prefer
        }
        //dd($searchMerchant);
        $query = Deposit::orderBy('deposit_request.id', 'desc');

        if ($searchQuery !== null) {
            $query->where('deposit_request.to_crypto_wallet_address', 'like', '%' . $searchQuery . '%');
        }

        if ($searchDepositId !== null) {
            $query->where('deposit_request.depositID', 'like', '%' . $searchDepositId . '%');
        }

        if ($selectedFilter !== null) {
            $query->where('deposit_request.status', $selectedFilter);
        } else {
            $query->whereIn('deposit_request.status', [0, 1, 2]);
        }


        $dateFilter = Carbon::parse($dateFilter)->toDateString();  // Adjust for timezone
        if ($dateFilter !== null) {
            $query->whereDate('deposit_request.created_at', '=', $dateFilter);
        }

        // $query->whereNotIn('users.role_id', [2]);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {
            $findMrchent    =  User::where('id', $item->merchant_id)->first();
            $countBulkAdd   =  BulkAddress::where('merchant_id', $item->merchant_id)->where('status', 1)->get();

            $address = $item->to_crypto_wallet_address ?? "";
            $shortAddress = $address ? substr($address, 0, 4) . "..." . substr($address, -4) : "";


            $depositId = $item->depositID ?? "";
            $shortDepositId = $depositId ? substr($depositId, 0, 4) . "..." . substr($depositId, -8) : "";

            return [
                'id'            => $item->id,
                'merchant_id'   => $item->merchant_id,
                'company_name'  => $findMrchent->company_name ?? "",
                'name'          => $findMrchent->name ?? "",
                'username'      => $item->username ?? "",
                'depositID'     => $shortDepositId ?? "",
                'fulldepositID' => $item->depositID ?? "",
                'user_id'       => $item->user_id ?? "",
                'deposit_amount' => $item->deposit_amount ?? "",
                'towallet'      => $shortAddress ?? "",
                'created_at'    => date("Y-M-d H:i:s", strtotime($item->created_at)),
                'updated_at'    => date("Y-M-d H:i:s", strtotime($item->updated_at)),
                'status'        => $item->status,
                'fulladd'       => $item->to_crypto_wallet_address,


                // 'countBulkAdd'  => count($countBulkAdd),
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



    public function countMerchantData()
    {

        try {
            // Retrieve counts
            $countDeposit        = Deposit::where('status', 1)->count();
            $countDepositAmt     = Deposit::where('status', 1)->sum('deposit_amount');
            $countMerchant       = User::where('role_id', 2)->where('status', 1)->count();
            $countBulkAddress    = BulkAddress::where('status', 1)->count();
            $countApiKey         = ApiKey::where('status', 1)->count();

            // Prepare JSON response
            return response()->json([
                'success' => true,
                'data' => [
                    'countDeposit'          => $countDeposit,
                    'countDepositAmt'       => number_format($countDepositAmt, 2),
                    'countMerchant'         => $countMerchant,
                    'countBulkAddress'      => $countBulkAddress,
                    'countApiKey'           => $countApiKey,
                ],
                'message' => 'Counts retrieved successfully',
            ], 200);
        } catch (\Exception $e) {
            // Handle exception and return error response
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve counts',
                'error' => $e->getMessage(),
            ], 500);
        }
    }







    public function getDepositfetchdata(Request $request)
    {
        try {
            $today = date("Y-m-d");
            $query = Deposit::select(
                'id',
                'depositID',
                'merchant_id',
                'user_id',
                'username',
                DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as created_at"),
                'deposit_amount',
                'status',
                'to_crypto_wallet_address'
            )
                ->whereDate('created_at', $today) // Ensure date matching for only year-month-date
                ->orderBy('created_at', 'desc')
                ->get();

            $result = [];

            foreach ($query as $key => $v) {
                $merchantrow = User::where('id', $v->merchant_id)->where('status', 1)->first();
                $result[] = [
                    'id'                => $v->id,
                    'depositID'         => $v->depositID,
                    'user_id'           => $v->user_id,
                    'username'          => $v->username,
                    'deposit_amount'    => $v->deposit_amount,
                    'status'            => $v->status,
                    'created_at'        => date("d-m-Y H:i:s", strtotime($v->created_at)),
                    'merchant_name'     => !empty($merchantrow->name) ? $merchantrow->name : "",
                    'to_crypto_wallet_address' => $v->to_crypto_wallet_address,
                ];
            }

            return response()->json($result, 200); // Success response
        } catch (\Exception $e) {
            return response()->json([
                'error'   => true,
                'message' => 'An error occurred while processing your request.',
                'details' => $e->getMessage(), // Optional: Include error details for debugging
            ], 500); // Internal Server Error response
        }
    }

    /*

    public function updateDepositRequest(Request $request)
    {

        try {
            $validator = Validator::make($request->all(), [
                'receivable_amount'  => 'required|numeric',
                'status'             => 'required|numeric',
                'id' => 'required',
            ]);
            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            $deposit = Deposit::find($request->id);
            $deposit->update([
                'receivable_amount' => $request->receivable_amount,
                'status'            => $request->status,
                'approved_by'       => $this->userid
            ]);
            return response()->json(['message' => 'Deposit updated successfully'], 200);
        } catch (QueryException $e) {
            // Log the error or handle it as needed
            return response()->json(['error' => 'Database error occurred.'], 500);
        } catch (\Exception $e) {
            // Handle other exceptions
            return response()->json(['error' => 'An unexpected error occurred.'], 500);
        }
    }

    function generateUnique4DigitNumber($existingNumbers = [])
    {
        do {
            $uniqueNumber = str_pad(mt_rand(0, 9999), 4, '0', STR_PAD_LEFT);
        } while (in_array($uniqueNumber, $existingNumbers));

        return md5($uniqueNumber);
    }

     public function withdrawrow($id)
    {

        try {

            $user = Withdraw::where('withdraw.id', $id)
                ->select('users.name', 'withdraw.*')
                ->join('users', 'withdraw.user_id', '=', 'users.id')
                ->first();

            $wallet_address         = !empty($user->wallet_address) ? $user->wallet_address : "";
            $data['datarow']        = $user;
            $data['created_at']     = !empty($user->created_at) ? date("d-m-Y H:i:s", strtotime($user->created_at)) : "";
            $data['remarks']        = !empty($user->remarks) ? $user->remarks : "";
            $data['wallet_address'] = $wallet_address;
            return response()->json($data);
        } catch (\Exception $e) {
            echo "Error: " . $e->getMessage();
            $error = $e->getMessage();
            return response()->json($error);
        }
    }

     public function filterRechargeList(Request $request)
    {

        // Get search query from the request
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        $searchUserEmail    = $request->searchUserEmail;
        $searchTranId       = $request->searchOrderId;
        $sDate              = $request->startDate;
        $eDate              = $request->endDate;
        $selectedStatus     = $request->selectedStatus;
        $startDate = Carbon::parse($sDate)->startOfDay();
        $endDate = Carbon::parse($eDate)->endOfDay();

        // dd($selectedFilter);
        $query = Deposit::orderBy('deposit.id', 'desc')
            ->join('users', 'deposit.user_id', '=', 'users.id')
            ->select('deposit.*', 'users.name as username', 'users.telegram', 'users.phone_number', 'users.whtsapp', 'users.email');

        if ($searchUserEmail !== null) {
            $query->where('users.email', 'like', '%' . $searchUserEmail . '%');
            //$query->where('users.email', $searchUserEmail);
        }

        if ($searchTranId !== null) {
            $query->where('deposit.depositID', 'like', '%' . $searchTranId . '%');
            //$query->where('users.email', $searchOrderId);
        }

        if ($selectedStatus !== null) {
            $query->where('deposit.status', $selectedStatus);
        }

        // Apply date range filtering if start and end dates are provided
        if ($startDate !== null && $endDate !== null) {
            $query->whereBetween('deposit.created_at', [$startDate, $endDate]);
        }

        // $query->where('users.role_id', 2);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);
        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $checkStatus    = $item->status == 1 ? 'SUCCESS' : 'UNPAID';
            $telegram       = !empty($item->telegram) ? $item->telegram : "None";
            $phone          = !empty($item->phone_number) ? $item->phone_number : "";
            $whtsapp        = !empty($item->whtsapp) ? $item->whtsapp : "None";

            return [
                'id'            => $item->id,
                'depositID'     => $item->depositID,
                'userInfo_1'    => $item->username,
                'userInfo_2'    => $phone,
                'userInfo_3'    => $item->email,
                'userInfo_4'    => $telegram,
                'deposit_date'  => date("Y-M-d", strtotime($item->created_at)),
                'deposit_amount' => $item->deposit_amount,
                'wallet_address' => $item->wallet_address,
                'receivable_amount' => $item->receivable_amount,
                'depscription'  => $item->depscription,
                'status'        => $checkStatus,
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

    public function updateWithDrawRequest(Request $request)
    {

        try {
            $validator = Validator::make($request->all(), [
                'remarks'             => 'required',
                'status'              => 'required|numeric',
                'id'                  => 'required',
            ]);
            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            $deposit = Withdraw::find($request->id);
            $deposit->update([
                'remarks'           => $request->remarks,
                'status'            => 2, //$request->status,
                'approved_by'       => $this->userid
            ]);
            return response()->json(['message' => 'Withdraw updated successfully'], 200);
        } catch (QueryException $e) {
            // Log the error or handle it as needed
            return response()->json(['error' => 'Database error occurred.'], 500);
        } catch (\Exception $e) {
            // Handle other exceptions
            return response()->json(['error' => 'An unexpected error occurred.'], 500);
        }
    }

     public function withdrawRequest(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'withdrawal_amount'  => 'required',
            'wallet_address'     => 'required',
            'withdrawal_pin'   => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = User::find($this->userid);
        // Check if the user exists
        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Check if the provided password matches the user's password
        if ($request->withdrawal_pin !== $user->new_pin) {
            return response()->json(['errors' => ['withdrawal_pin' => ['Incorrect PIN']]], 422);
        }

        $userid        = $this->userid;
        $depositAmount = Deposit::where('user_id', $userid)->select('deposit_amount')->where('status', 1)->sum('deposit_amount');
        $setting       = Setting::find(1);
        $walletInfo    = UserPaymentAddress::where('user_id', $userid)->first();

        if ($request->withdrawal_amount < $setting->minimum_withdrawal) {
            return response()->json(['errors' => ['error_minim_usdt' => ['Minimum USDT balance is ', $setting->minimum_withdrawal]]], 422);
        }

        if ($request->withdrawal_amount > $depositAmount) {
            return response()->json(['errors' => ['error_usdt' => ['You have no sufficiant USDT balance']]], 422);
        }

        $chkloanAmt     = LoanPayHistory::where('type', 1)->where('status', 0)->sum('amount');
        $loanAmount     = abs($chkloanAmt);

        $chkPayloanAmt  = LoanPayHistory::where('type', 2)->where('status', 1)->sum('amount');
        $loanPayAmount  = abs($chkPayloanAmt);

        $payResult = $loanAmount - $loanPayAmount;

        //dd($payResult);

        if ($payResult > 0) {
            return response()->json(['errors' => ['error_usdt' => ["Your pay amount must not be greater than the loan amount. Loan Amount is $payResult USDT"]]], 422);
        }

        $uniqueID = 'W.' . $this->generateUnique4DigitNumber();
        $data = array(
            'withdrawID'     => $uniqueID,
            'depscription'   => $uniqueID,
            'withdrawal_amount' => $request->withdrawal_amount,
            'wallet_address' => $walletInfo->wallet_address,
            'withdrawal_pin' => $request->withdrawal_pin,
            'status'         => 0,
            'payment_method' => 'TRX(TRC20)',
            'user_id'        => $this->userid
        );
        $last_Id = Withdraw::insertGetId($data);

        $tran['user_id']     = $this->userid;
        $tran['type']        = 2; //Withdraw
        $tran['last_Id']     = $last_Id;
        $tran['amount']      = $request->withdrawal_amount;
        $tran['description'] = 'Withdraw';
        TransactionHistory::insert($tran);

        return response()->json(['data' => 'Successfully send your request.'], 200);
    } 
    public function getWithMethodList()
    {
        $data     = WithdrawMethod::where('user_id', $this->userid)->get();
        foreach ($data as $v) {

            $tran[] = [
                'id'             => $v->id,
                'name'     => $v->name,
                'account_number' => $v->account_number,
            ];
        }

        return response()->json($tran, 200);
    }
        
     public function getWithdrawRequest()
    {

        $data     = Withdraw::where('user_id', $this->userid)->get();
        foreach ($data as $v) {

            if ($v->status == 0) {
                $wStatus = 'Review';
            } elseif ($v->status == 1) {
                $wStatus = 'Approved';
            } elseif ($v->status == 2) {
                $wStatus = 'Reject';
            }

            $tran[] = [
                'id'             => $v->id,
                'withdrawID'     => $v->withdrawID,
                'payment_method' => $v->payment_method,
                'account_number' => $v->account_number,
                'wStatus'        => $wStatus,
                'status'         => $v->status,
                'usd_amount'     => $v->usd_amount,
                'uic_amount'     => $v->uic_amount,
                'created_at'     => date("d-m-Y H:i:s", strtotime($v->created_at)),
            ];
        }

        return response()->json($tran, 200);
    }

    public function getwithdrawalList(Request $request)
    {
        // dd($request->all());
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        $searchEmail    = $request->searchEmail;
        $filterFrmDate  = $request->filterFrmDate;
        $filterToDate   = $request->filterToDate;
        $searchOrderId  = $request->searchOrderId;

        $query = Withdraw::orderBy('withdraw.id', 'desc')
            ->select('withdraw.*', 'users.name', 'users.email', 'users.phone_number')
            ->join('users', 'withdraw.user_id', '=', 'users.id') // Join condition
            ->orderBy('withdraw.id', 'desc'); // Sorting by 'id' in descending order

        if (!empty($searchOrderId)) {
            $query->where('withdraw.withdrawID', $searchOrderId);
        }

        // Check if filter dates are provided
        if (!empty($filterFrmDate) && !empty($filterToDate)) {
            // Filter by range (inclusive)
            $query->whereBetween(DB::raw('DATE(withdraw.created_at)'), [$filterFrmDate, $filterToDate]);
        } elseif (!empty($filterFrmDate)) {
            // If only from date is provided, filter by that specific date
            $query->where(DB::raw('DATE(withdraw.created_at)'), $filterFrmDate);
        } elseif (!empty($filterToDate)) {
            // If only to date is provided, filter by that specific date
            $query->where(DB::raw('DATE(withdraw.created_at)'), $filterToDate);
        }

        if (!empty($searchEmail)) {
            $query->where('users.email', $searchEmail);
        }

        $cleanedSelectedFilter = isset($selectedFilter) ? (int) trim($selectedFilter) : null;

        if ($cleanedSelectedFilter == 5) {
            $query->whereIn('withdraw.status', [0, 1, 2]);
        } else {
            $query->where('withdraw.status', $cleanedSelectedFilter);
        }

        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $status = "";
            if ($item->status == 0) {
                $status = "Review";
            } else if ($item->status == 1) {
                $status = "Approved";
            } else if ($item->status == 2) {
                $status = "Rejected";
            }
            $userrow = User::find($item->user_id);
            return [
                'id'                => $item->id,
                'withdrawID'        => $item->withdrawID,
                'user_info_name'    => !empty($userrow->name) ?  $userrow->name : "N/A",
                'user_info_email'   => !empty($userrow->email) ?  $userrow->email : "N/A",
                'user_info_phone'   => !empty($userrow->phone_number) ?  $userrow->phone_number : "N/A",
                'created_at'        => date("Y-m-d H:i:s", strtotime($item->created_at)),
                'usd_amount'        => $item->usd_amount,
                'uic_amount'        => $item->uic_amount,
                'payable_amount'    => $item->payable_amount,
                'transection_fee'   => $item->transection_fee,
                'withdrawal_method_id' => $item->withdrawal_method_id,
                'status'            => $status,
                'sts'               => $item->status,
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
    */

    // public function getWithdrwalfetchdata(Request $request)
    // {

    //     $userId           = $this->userid;
    //     $frmDate          = $request->frmDate;
    //     $toDate           = $request->toDate;
    //     $withdrawal_Id    = $request->withdrawal_Id;

    //     $query = Withdraw::where('user_id', $userId)->select('id', 'withdrawID', 'created_at', 'withdrawal_amount', 'remarks', 'status');

    //     if ($withdrawal_Id) {
    //         $query->where('withdrawID', 'like', '%' . $withdrawal_Id . '%');
    //     }
    //     if ($frmDate && $toDate) {
    //         $query->whereBetween('created_at', [$frmDate, $toDate]);
    //     } elseif ($frmDate) {
    //         $query->where('created_at', '>=', $frmDate);
    //     } elseif ($toDate) {
    //         $query->where('created_at', '<=', $toDate);
    //     }

    //     $data = $query->get();

    //     return response()->json([
    //         'withdrwalData'        => $data,
    //     ]);
    // }

    /*
    public function getDepositfetchdata(Request $request)
    {

        $userId           = $this->userid;
        $frmDate          = $request->frmDate;
        $toDate           = $request->toDate;
        $trxId            = $request->trxId;

        $query = Deposit::where('user_id', $userId)->select('id', 'trxId', 'created_at', 'deposit_amount', 'status');

        if ($trxId) {
            $query->where('trxId', 'like', '%' . $trxId . '%');
            // $query->where('trxId', $trxId);
        }
        if ($frmDate && $toDate) {
            $query->whereBetween('created_at', [$frmDate, $toDate]);
        } elseif ($frmDate) {
            $query->where('created_at', '>=', $frmDate);
        } elseif ($toDate) {
            $query->where('created_at', '<=', $toDate);
        }

        $data = $query->get();

        $response      = app('App\Http\Controllers\Balance\BalanceController')->getBalance();
        $depositAmount = $response instanceof JsonResponse ? $response->getData(true)['usdt_amount'] : 0;
        $maxWithdraw   = Setting::find(1);
        $walletAddress = UserPaymentAddress::where('user_id', $userId)->first();

        $wdata['minimum_withdrawal'] = $maxWithdraw->minimum_withdrawal;
        $wdata['maximum_withdrawal'] = $maxWithdraw->maximum_withdrawal;

        return response()->json([
            'depositData'        => $data,
            'depositAmount'      => $depositAmount,
            'withdrawData'       => $wdata,
            'walletAddress'      => $walletAddress,
        ]);
    }
        */

    public function getDepositList(Request $request)
    {

        $page           = $request->input('page', 1);
        $pageSize       = $request->input('pageSize', 10);
        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        $searchEmail    = $request->searchEmail;
        $filterFrmDate  = $request->filterFrmDate;
        $filterToDate   = $request->filterToDate;
        $searchOrderId  = $request->searchOrderId;

        // dd($selectedFilter);
        $query = Deposit::orderBy('deposit.id', 'desc')
            ->join('users', 'deposit.user_id', '=', 'users.id') // Join condition
            ->select('deposit.*', 'users.email', 'users.name', 'users.phone_number')
            ->orderBy('deposit.id', 'desc'); // Sorting by 'id' in descending order

        // Check if filter dates are provided
        if (!empty($filterFrmDate) && !empty($filterToDate)) {
            // Filter by range (inclusive)
            $query->whereBetween(DB::raw('DATE(deposit.created_at)'), [$filterFrmDate, $filterToDate]);
        } elseif (!empty($filterFrmDate)) {
            // If only from date is provided, filter by that specific date
            $query->where(DB::raw('DATE(deposit.created_at)'), $filterFrmDate);
        } elseif (!empty($filterToDate)) {
            // If only to date is provided, filter by that specific date
            $query->where(DB::raw('DATE(deposit.created_at)'), $filterToDate);
        }

        if (!empty($searchEmail)) {
            $query->where('users.email', $searchEmail);
        }

        if (!empty($searchOrderId)) {
            // $query->where('depositID', 'like', '%' . $searchQuery . '%');
            $query->where('deposit.depositID', $searchOrderId);
        }

        // $cleanedSelectedFilter = isset($selectedFilter) ? (int) trim($selectedFilter) : null;

        if ($selectedFilter == 5) {
            $query->whereIn('deposit.status', [0, 1, 2]);
        } else {
            $query->where('deposit.status', $selectedFilter);
        }

        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $status = "";
            if ($item->status == 0) {
                $status = "Review";
            } else if ($item->status == 1) {
                $status = "Approved";
            } else if ($item->status == 2) {
                $status = "Rejected";
            }
            //Payment not received
            $userrow = User::find($item->user_id);
            return [
                'id'                => $item->id,
                'depositID'         => $item->depositID,
                'user_info_name'    => !empty($userrow->name) ?  $userrow->name : "N/A",
                'user_info_email'   => !empty($userrow->email) ?  $userrow->email : "N/A",
                'user_info_phone'   => !empty($userrow->phone_number) ?  $userrow->phone_number : "N/A",
                'deposit_amount'    => $item->deposit_amount,
                'receivable_amount' => !empty($item->receivable_amount) ? $item->receivable_amount : "Payment not received",
                'payment_method'    => $item->payment_method,
                'created_at'        =>  date("Y-m-d H:i:s", strtotime($item->created_at)),
                'status'            => $status,
                'sts'               => $item->status,
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

    public function depositrow($id)
    {

        try {
            $user = Deposit::where('deposit.id', $id)
                ->select('users.name', 'deposit.*')
                ->leftJoin('users', 'deposit.user_id', '=', 'users.id')
                ->first();
            return response()->json($user);
        } catch (\Exception $e) {
            echo "Error: " . $e->getMessage();
            $error = $e->getMessage();
            return response()->json($error);
        }
    }
}
