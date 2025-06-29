<?php

namespace App\Models;
// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use AuthorizesRequests;
use DB;

class PurchaseInvoice extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    public $table = "purchase_invoice";
    protected $fillable = [
        'name',
        'email',
        'phone',
        'invoice_no',
        'address',
        'item_total',
        'advance_amount',
        'due_amount',
        'discount_amount',
        'after_discount',
        'tax_percentage',
        'tax_amount',
        'grand_total',
        'invoice_create_by',
    ];
}
