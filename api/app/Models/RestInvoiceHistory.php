<?php

namespace App\Models;
// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use AuthorizesRequests;
use DB;

class RestInvoiceHistory extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    public $table = "restaruent_invoice_history";
    protected $fillable = [
        'rest_invoice_id',
        'item_id',
        'name',
        'qty',
        'price',
        'total',
        'invoice_create_by',
    ];
}
