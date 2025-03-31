<?php

namespace App\Http\Controllers\Public;

use Cart;
use Carbon\Carbon;
use App\Models\Deposit;
use App\Models\User;
use App\Models\ApiKey;
use App\Models\BulkAddress;
use Illuminate\Http\Request;
use App\Models\GamelistTransate;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Log;

class PublicController extends Controller
{


    public function getLogApiReport()
    {

        $logFilePath = storage_path('logs/api-log.log');

        if (file_exists($logFilePath)) {
            $logContent = file_get_contents($logFilePath);
            return response()->json([
                'status' => 'success',
                'data' => $logContent,
            ], 200);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Log file not found.',
            ], 404);
        }
    }


    public function depositRequest(Request $request)
    {

        // Check if the incoming request is JSON
        if ($request->isJson()) {
            Log::info('Received DEPOSIT JSON request', ['request_data' => $request->all()]);
            $validatedData = $request->validate([
                'depositID'  => 'required',
                'user_id'    => 'required|integer',
                'username'   => 'required',
                'merchant_id' => 'required|integer',
                'amount'     => 'required|numeric',
                'to_crypto_wallet_address' => 'required',
                'status'     => 'required|integer',
            ]);



            $depositId = $validatedData['depositID'];
            $checkDeposit = Deposit::where('depositID', $depositId)->first();

            if (empty($checkDeposit)) {

                // Insert the data into the Deposit model
                $deposit = Deposit::create([
                    'depositID'             => $validatedData['depositID'],
                    'user_id'               => $validatedData['user_id'],
                    'username'              => $validatedData['username'],
                    'merchant_id'           => $validatedData['merchant_id'],
                    'deposit_amount'        => $validatedData['amount'],
                    'status'                => $validatedData['status'],
                    'to_crypto_wallet_address' => $request->to_crypto_wallet_address,
                ]);
                // Log::info('Received DEPOSIT AFTER request', ['request_data' => $deposit]);



                $to_crypto_wallet_address = $validatedData['to_crypto_wallet_address'];
                $checkWalletAddreess      = BulkAddress::where('walletAddress', $to_crypto_wallet_address)->first();

                $checkWalletAddreess->block_status = 1;
                $checkWalletAddreess->save(); // Save the changes to the database
                // Respond with a success message
                return response()->json([
                    'message' => 'Deposit received and inserted successfully',
                    'deposit' => $deposit
                ], 200);
            }
        } else {
            // Log the error if it's not a JSON request
            Log::warning('Non-JSON request received.');
            // Respond with an error if the request is not JSON
            return response()->json(['message' => 'Request must be JSON'], 400);
        }
    }

    public function getwalleteAddress(Request $request)
    {

        $request->validate([
            'api_key'  => 'required',
            'password' => 'required',
        ]);

        // Fetch API key and password from request
        $api_key  = $request->api_key;
        $password = $request->password;

        // Query database for matching record
        $chkData = ApiKey::where('key', $api_key)
            ->where('password', $password)
            ->first();
        $merchentId = !empty($chkData) ? $chkData->merchant_id : "";


        $chkmerchant = BulkAddress::where('merchant_id', $merchentId)->where('status', 1)->where('block_status', 0)->inRandomOrder()->first(); // Get a single random row
        $mId         = $merchentId;
        

        if ($chkmerchant) {
            $list = [
                'id'            => (int)$chkmerchant->id,
                'merchant_id'   => $mId,
                'walletAddress' => $chkmerchant->walletAddress,
            ];
        } else {
            $list = []; // Return an empty array if no data is found
        }


        $chkMechant = User::where('id',3)->first();
        //dd($chkMechant);
        
        $chkmerchant['slug']= "After request send api/deposit/sendDepositRequest response result put this slug";

        // Return response in JSON format
        if ($chkmerchant) {
            return response()->json([
                'status'  => 'success',
                'message' => 'Wallet address retrieved successfully.',
                'data'    => $chkmerchant,
            ], 200); // HTTP status code 200 (OK)
        }

        // Return error response if no data found
        return response()->json([
            'status'  => 'error',
            'message' => 'Invalid API key or password.',
        ], 404); // HTTP status code 404 (Not Found)
    }


    public function getTronApiReport(Request $request)
    {

        // dd($request->all());
        $contractAddress = !empty($request->searchQuery) ? $request->searchQuery : "";
        // Define the API URL
        $apiUrl = "https://api.trongrid.io/v1/accounts/{$contractAddress}/transactions/trc20?limit=1&only_confirmed=true";
        // Initialize cURL session
        $ch = curl_init();
        // Set cURL options
        curl_setopt($ch, CURLOPT_URL, $apiUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
        ]);
        // Execute the API request
        $response = curl_exec($ch);
        // Check for cURL errors
        if (curl_errno($ch)) {
            echo "cURL Error: " . curl_error($ch);
            exit;
        }
        // Close the cURL session
        curl_close($ch);

        // Decode the JSON response
        $data = json_decode($response, true);

        // Check if the response contains data
        if (isset($data['data']) && !empty($data['data'])) {
            echo "Last Transactions Details:\n";
            foreach ($data['data'] as $transaction) {
                // Extract transaction details
                $transactionId = $transaction['transaction_id'] ?? 'N/A';
                $from = $transaction['from'] ?? 'N/A';
                $to = $transaction['to'] ?? 'N/A';
                $amount = isset($transaction['value']) && isset($transaction['token_info']['decimals'])
                    ? $transaction['value'] / pow(10, $transaction['token_info']['decimals'])
                    : 'N/A';
                $timestamp = $transaction['block_timestamp'] ?? 'N/A';

                // Convert amount to USDT (assuming 1 unit of token equals 1 USDT)
                $amountInUsdt = is_numeric($amount) ? number_format($amount, 2) . ' USDT' : 'N/A';

                // Convert timestamp to a readable date
                $dateTime = $timestamp !== 'N/A' ? date('Y-m-d H:i:s', $timestamp / 1000) : 'N/A';

                // Display the transaction details
                echo "-----------------------------------\n";
                echo "Transaction ID: {$transactionId}\n";
                echo "From: {$from}\n";
                echo "To: {$to}\n";
                echo "Amount: {$amountInUsdt}\n";
                echo "Date and Time: {$dateTime}\n";
            }
        } else {
            echo "No transactions found for the provided contract address.";
        }
    }

    public function checkMerchentDetails(Request $request)
    {

        $request->validate([
            'api_key'  => 'required',
            'password' => 'required',
        ]);


        $api_key  = $request->api_key;
        $password = $request->password;

        // Query database for matching record
        $chkData = ApiKey::where('key', $api_key)
            ->select('merchant_id')
            ->where('password', $password)
            ->first();

        if ($chkData) {
            return response()->json([
                'status'  => 'success',
                'message' => 'Merchent information retrieved successfully.',
                'data'    => $chkData,
            ], 200); // HTTP status code 200 (OK)
        }

        return response()->json([
            'status'  => 'error',
            'message' => 'Invalid API key or password.',
        ], 404); // HTTP status code 404 (Not Found)
    }




    public function dynamicMenuLeftSidebar()
    {
        $menu = [
            [
                'label' => 'Dashboard',
                'path' => '/dashboard',
                'icon' => 'bx bx-home-alt',
                'submenu' => []
            ],
            [
                'label' => 'Transaction Report',
                'path' => '/report/deposit-report',
                'icon' => 'bx bx-repeat',
                'submenu' => []
            ],
            [
                'label' => 'Room Management',
                'path' => '#',
                'icon' => 'bx bx-category',
                'submenu' => [
                    ['label' => 'Bed Type List', 'path' => '/roomsetting/bed-type-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Booking Type List', 'path' => '/roomsetting/booking-type-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Room Size', 'path' => '/roomsetting/room-size-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Room List', 'path' => '/roomsetting/room-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Room Images', 'path' => '/roomsetting/room-images-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Promocode List', 'path' => '/roomsetting/promocode-list', 'icon' => 'bx bx-radio-circle'],
                ]
            ],
            [
                'label' => 'Users Management',
                'path' => '#',
                'icon' => 'bx bx-category',
                'submenu' => [
                    ['label' => 'Role List', 'path' => '/user/role-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Super Admin List', 'path' => '/user/superadmin-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Admin List', 'path' => '/user/admin-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Users List', 'path' => '/user/users-list', 'icon' => 'bx bx-radio-circle']
                ]
            ],
            /*
            [
                'label' => 'Post Management',
                'path' => '#',
                'icon' => 'bx bx-category',
                'submenu' => [
                    ['label' => 'Post Category', 'path' => '/category/post-category-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Post List', 'path' => '/post/post-list', 'icon' => 'bx bx-radio-circle']
                ]
            ],
            */
            [
                'label' => 'System Management',
                'path' => '#',
                'icon' => 'bx bx-category',
                'submenu' => [
                    ['label' => 'Global Category', 'path' => '/category/global-category-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Global Wallet Address', 'path' => '/wallet/global-wallet-address-list', 'icon' => 'bx bx-radio-circle'],
                   // ['label' => 'Confirgration API Key', 'path' => '/configration/config-api-key-list', 'icon' => 'bx bx-radio-circle'],
                   // ['label' => 'Merchant Request', 'path' => '/configration/config-api-key-list', 'icon' => 'bx bx-radio-circle']
                ]
            ]
        ];

        return response()->json($menu);
    }
}
