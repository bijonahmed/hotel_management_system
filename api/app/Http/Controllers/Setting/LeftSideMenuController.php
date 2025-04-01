<?php

namespace App\Http\Controllers\Setting;

use Cart;
use Carbon\Carbon;
use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Log;

class LeftSideMenuController extends Controller
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
                'label' => 'Room Facilites',
                'path' => '#',
                'icon' => 'bx bx-category',
                'submenu' => [
                    ['label' => 'Facilites Group', 'path' => '/facilites/facilites-group-list', 'icon' => 'bx bx-radio-circle'],
                    ['label' => 'Facilites List', 'path' => '/facilites/facilites-list', 'icon' => 'bx bx-radio-circle'],
                   
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
