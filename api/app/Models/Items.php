<?php

namespace App\Models;
// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use AuthorizesRequests;
use DB;

class Items extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    public $table = "items";
    protected $fillable = [
        'name',
        'quantity',
        'unit_price',
        'status',
        'notes',

    ];
}
