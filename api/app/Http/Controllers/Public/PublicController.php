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
}
