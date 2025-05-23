<?php

namespace App\Models;
// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use AuthorizesRequests;
use DB;

class Booking extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    public $table = "booking";
    protected $fillable = [
        'name',
        'email',
        'phone',
        'checkin',
        'checkout',
        'booking_id',
        'paymenttype',
        'room_price',
        'room_id',
        'adult',
        'child',
        'booking_type',
        'room_no',
        'country_code',
        'customer_title',
        'customer_first_name',
        'customer_last_name',
        'customer_father_name',
        'customer_gender',
        'customer_occupation',
        'customer_dob',
        'customer_nationality',
        'customer_contact_type',
        'customer_contact_address',
        'customer_contact_email',
        'id_no',
        'front_side_document',
        'back_side_document',
        'booking_reference_no',
        'pupose_of_visit',
        // amt
        'advance_amount',
        'total_bill',
        'due_amount',
        'discount_amount',
        'final_total_amount',
        'tax_amount',
        'item_total',
        'grand_total',
        'total_amount',
        // amt
        'message',
        'customer_id',
        'arival_from',
        'update_by',
        'check_out_reason',
        'invoice_create_by',
        'invoice_create',
        'check_in_by',
        'booking_status'
    ];
}
