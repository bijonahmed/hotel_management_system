<?php

namespace App\Http\Controllers\Public;

use Cart;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Room;
use App\Models\RoomImages;
use App\Models\SelectedRoomFacility;
use App\Models\Service;
use App\Models\Setting;
use App\Models\Sliders;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Log;
use Validator;
use Illuminate\Support\Facades\DB;

class PublicController extends Controller
{


    public function filterBooking(Request $request)
    {
        //  dd($request->all());
        $validator = Validator::make(
            $request->all(),
            [
                'check_in'  => 'required|date',
                'check_out' => 'required|date|after_or_equal:check_in',
            ],
            [
                'check_in.required' => 'The check-in date is required.',
                'check_in.date'     => 'The check-in must be a valid date.',
                'check_out.required' => 'The check-out date is required.',
                'check_out.date'     => 'The check-out must be a valid date.',
                'check_out.after_or_equal' => 'The check-out date must be after or equal to the check-in date.',
            ]
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        /*
        // Fetch available rooms (booking_status = 2 or NULL)
        $rooms = Room::where('booking_status', 2)
            ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id') // Fixing bed_type join
            ->leftJoinSub(
                \DB::table('room_images')
                    ->select('room_id', \DB::raw('MIN(id) as min_id')) // Get first image ID
                    ->groupBy('room_id'),
                'first_images',
                'room.id',
                '=',
                'first_images.room_id'
            )
            ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id') // Join first image
            ->orWhereNull('booking_status')
            ->select('room.slug', 'room.id', 'room.name', 'room.roomDescription', 'bed_type.name as bed_name', 'roomPrice', 'room_images.roomImage')
            ->get()
            ->map(function ($room) {
                return [
                    'room_id'         => $room->id,
                    'name'            => $room->name,
                    'slug'            => $room->slug,
                    'bed_name'        => $room->bed_name,
                    'roomPrice'       => number_format($room->roomPrice, 2),
                    'roomDescription' =>  Str::limit($room->roomDescription, 50), // Limit to 50 characters,
                    'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                ];
            });
*/

        /*
        $rooms = Room::join('booking', function ($join) use ($today) {
            $join->on('room.id', '=', 'booking.room_id')
                ->where('booking.booking_status', '=', 1)
                ->whereDate('booking.checkIn', '<=', $today);
        })
            ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id')
            ->leftJoinSub(
                \DB::table('room_images')
                    ->select('room_id', \DB::raw('MIN(id) as min_id'))
                    ->groupBy('room_id'),
                'first_images',
                'room.id',
                '=',
                'first_images.room_id'
            )
            ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id')
            ->select(
                'room.slug',
                'room.id',
                'room.name',
                'room.roomDescription',
                'bed_type.name as bed_name',
                'roomPrice',
                'room_images.roomImage'
            )
            ->distinct()
            ->get()
            ->map(function ($room) {
                return [
                    'room_id'         => $room->id,
                    'name'            => $room->name,
                    'slug'            => $room->slug,
                    'bed_name'        => $room->bed_name,
                    'roomPrice'       => number_format($room->roomPrice, 2),
                    'roomDescription' => Str::limit($room->roomDescription, 50),
                    'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                ];
            });
    */

        /*
        RIGHT QUERY: 
        $roomsStatusTwo = Room::where(function ($query) {
            $query->where('room.booking_status', 2)
                ->orWhereNull('room.booking_status');
        })
            ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id')
            ->leftJoinSub(
                \DB::table('room_images')
                    ->select('room_id', \DB::raw('MIN(id) as min_id'))
                    ->groupBy('room_id'),
                'first_images',
                'room.id',
                '=',
                'first_images.room_id'
            )
            ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id')
            ->select('room.slug', 'room.id', 'room.name', 'room.roomDescription', 'bed_type.name as bed_name', 'roomPrice', 'room_images.roomImage')
            ->get()
            ->map(function ($room) {
                return [
                    'room_id'         => $room->id,
                    'name'            => $room->name,
                    'slug'            => $room->slug,
                    'bed_name'        => $room->bed_name,
                    'roomPrice'       => number_format($room->roomPrice, 2),
                    'roomDescription' => Str::limit($room->roomDescription, 50),
                    'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                ];
            })->toArray(); // convert to array for easier merging

        // Get booked rooms where booking_status = 1 and checkIn <= today
        $checkinRequest = $request->check_in; //date('Y-m-d');
        // Step 1: Check if any record exists where checkin == request date
        $hasMatchingCheckin = Booking::where('booking.booking_status', 1)
            ->whereDate('checkin', $checkinRequest)
            ->exists();

        if ($hasMatchingCheckin) {
            // If matching checkin date found, return empty array
            $bookedRooms = [];
        } else {
            // Else, run the full query
            $bookedRooms = Booking::where('booking.booking_status', 1)
                ->where('checkin', '<=', $checkinRequest)
                ->join('room', 'booking.room_id', '=', 'room.id')
                ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id')
                ->leftJoinSub(
                    \DB::table('room_images')
                        ->select('room_id', \DB::raw('MIN(id) as min_id'))
                        ->groupBy('room_id'),
                    'first_images',
                    'room.id',
                    '=',
                    'first_images.room_id'
                )
                ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id')
                ->select(
                    'room.slug',
                    'room.id',
                    'room.name',
                    'room.roomDescription',
                    'bed_type.name as bed_name',
                    'roomPrice',
                    'room_images.roomImage'
                )
                ->get()
                ->map(function ($room) {
                    return [
                        'room_id'         => $room->id,
                        'name'            => $room->name,
                        'slug'            => $room->slug,
                        'bed_name'        => $room->bed_name,
                        'roomPrice'       => number_format($room->roomPrice, 2),
                        'roomDescription' => Str::limit($room->roomDescription, 50),
                        'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                    ];
                })->toArray();
        }
      
        $mergedRooms = collect($roomsStatusTwo)
            ->merge($bookedRooms)
            ->unique(function ($item) {
                return $item['room_id'];
            })
            ->values()
            ->all();
        return response()->json([
            'message' => 'Available rooms fetched successfully',
            'rooms' => $mergedRooms
        ], 200);

        */

        // Step 1: Check if any bookings exist at all
        $hasAnyBooking = DB::table('booking')->exists();

        $checkinRequest = $request->check_in; // e.g., '2025-05-31'

        // Step 2: If no booking exists, show all rooms
        if (!$hasAnyBooking) {
            $rooms = Room::leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id')
                ->leftJoinSub(
                    RoomImages::select('room_id', DB::raw('MIN(id) as min_id'))
                        ->groupBy('room_id'),
                    'first_images',
                    'room.id',
                    '=',
                    'first_images.room_id'
                )
                ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id')
                ->select(
                    'room.slug',
                    'room.id',
                    'room.name',
                    'room.roomDescription',
                    'bed_type.name as bed_name',
                    'roomPrice',
                    'room_images.roomImage'
                )
                ->get()
                ->map(function ($room) {
                    return [
                        'room_id'         => $room->id,
                        'name'            => $room->name,
                        'slug'            => $room->slug,
                        'bed_name'        => $room->bed_name,
                        'roomPrice'       => number_format($room->roomPrice, 2),
                        'roomDescription' => Str::limit($room->roomDescription, 50),
                        'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                    ];
                })->toArray();
        } else {
            // Step 3: Get rooms NOT booked (no booking with booking_status == 1 or checkin == request checkin)
            $bookedRoomIds = Booking::where('booking_status', 1)
                ->where(function ($query) use ($checkinRequest) {
                    $query->orWhereDate('checkin', $checkinRequest);
                })
                ->pluck('room_id')
                ->toArray();

            $rooms = Room::whereNotIn('room.id', $bookedRoomIds)
                ->where('room.status', 1)
                ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id')
                ->leftJoinSub(
                    RoomImages::select('room_id', DB::raw('MIN(id) as min_id'))
                        ->groupBy('room_id'),
                    'first_images',
                    'room.id',
                    '=',
                    'first_images.room_id'
                )
                ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id')
                ->select(
                    'room.slug',
                    'room.id',
                    'room.name',
                    'room.roomDescription',
                    'bed_type.name as bed_name',
                    'roomPrice',
                    'room_images.roomImage'
                )
                ->get()
                ->map(function ($room) {
                    return [
                        'room_id'         => $room->id,
                        'name'            => $room->name,
                        'slug'            => $room->slug,
                        'bed_name'        => $room->bed_name,
                        'roomPrice'       => number_format($room->roomPrice, 2),
                        'roomDescription' => Str::limit($room->roomDescription, 50),
                        'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                    ];
                })->toArray();
        }

        // Final response
        return response()->json([
            'message' => 'Available rooms fetched successfully',
            'rooms' => $rooms
        ], 200);
    }



    public function activeRooms(Request $request)
    {
        try {

            /*
            $rowsData = Room::where('room.status', 1)
                ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id') // Fixing bed_type join
                ->leftJoinSub(
                    \DB::table('room_images')
                        ->select('room_id', \DB::raw('MIN(id) as min_id')) // Get first image ID
                        ->groupBy('room_id'),
                    'first_images',
                    'room.id',
                    '=',
                    'first_images.room_id'
                )
                ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id') // Join first image
                ->select('room.slug', 'room.id', 'room.name', 'room.roomDescription', 'bed_type.name as bed_name', 'roomPrice', 'room_images.roomImage')
                ->get()
                ->map(function ($room) {
                    return [
                        'room_id'         => $room->id,
                        'name'            => $room->name,
                        'slug'            => $room->slug,
                        'bed_name'        => $room->bed_name,
                        'roomPrice'       => number_format($room->roomPrice, 2),
                        'roomDescription' =>  Str::limit($room->roomDescription, 50), // Limit to 50 characters,
                        'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : ""
                    ];
                });
            return response()->json($rowsData, 200);
            */
            // Base query for rooms with status = 1
            $roomsQuery = Room::where('room.status', 1)
                ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id')
                ->leftJoinSub(
                    \DB::table('room_images')
                        ->select('room_id', \DB::raw('MIN(id) as min_id')) // first image ID
                        ->groupBy('room_id'),
                    'first_images',
                    'room.id',
                    '=',
                    'first_images.room_id'
                )
                ->leftJoin('room_images', 'room_images.id', '=', 'first_images.min_id')
                ->select(
                    'room.slug',
                    'room.id',
                    'room.name',
                    'room.roomDescription',
                    'bed_type.name as bed_name',
                    'room.roomPrice',
                    'room_images.roomImage'
                );

            // Exclude rooms with booking_status = 1 in booking table
            $roomsQuery->whereNotIn('room.id', function ($query) {
                $query->select('room_id')
                    ->from('booking')
                    ->where('booking_status', 1);
            });

            $rowsData = $roomsQuery->get()->map(function ($room) {
                return [
                    'room_id'         => $room->id,
                    'name'            => $room->name,
                    'slug'            => $room->slug,
                    'bed_name'        => $room->bed_name,
                    'roomPrice'       => number_format($room->roomPrice, 2),
                    'roomDescription' => \Str::limit($room->roomDescription, 50),
                    'roomImage'       => !empty($room->roomImage) ? url($room->roomImage) : "",
                ];
            });

            return response()->json($rowsData, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    public function getSliders(Request $request)
    {
        try {
            $sliderImg = Sliders::where('status', 1)
                ->get()
                ->map(function ($slider) {
                    return [
                        'id'              => $slider->id,
                        'title_name'      => $slider->title_name,
                        'sliderImage'     => !empty($slider->sliderImage) ? url($slider->sliderImage) : ""
                    ];
                });

            return response()->json(['data' => $sliderImg], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function getRoomDetails(Request $request)
    {
        try {

            $roomParticular = Room::where('room.status', 1)->where('room.slug', $request->slug)
                ->select('room.*', 'bed_type.name as bed_name')
                ->leftJoin('bed_type', 'room.bed_type_id', '=', 'bed_type.id') // Fixing bed_type join
                ->first();

            $room_id          = $roomParticular->id;
            $activeRoomImg    = RoomImages::where('status', 1)
                ->where('room_id', $room_id)
                ->get()
                ->map(function ($room) {
                    // Check if roomImage exists and is not empty
                    return [
                        'roomImage' => !empty($room->roomImage) ? url($room->roomImage) : null // Returning null if empty
                    ];
                });

            $data['roomParticular'] = $roomParticular;
            $data['activeRoomImg']  = $activeRoomImg;

            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }




    public function checkselectedfacilities(Request $request)
    {

        try {
            $data = SelectedRoomFacility::where('room_id', $request->id)
                ->select('select_room_facilities.id', 'facility_group.name as facility_group_name', 'room.roomType as room_name', 'room_facility.name as facilities_name')
                ->leftJoin('facility_group', 'facility_group.id', '=', 'select_room_facilities.room_facility_group_id')
                ->leftJoin('room', 'room.id', '=', 'select_room_facilities.room_id')
                ->leftJoin('room_facility', 'room_facility.id', '=', 'select_room_facilities.facilities_id')
                ->orderby('id', 'desc')
                ->get();
            if ($data->isEmpty()) {
                return response()->json(['message' => 'No room sizes found'], 404);
            }
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function getGlobalData()
    {
        try {
            $data = Setting::where('id', 1)->first();
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    public function getGlobalSettingdata()
    {
        try {
            $data = Setting::where('id', 1)->first();

            $response = [
                'data'         => $data,
                'banner_image' => !empty($data->banner_image) ? url($data->banner_image) : "",
                'message' => 'success'
            ];
            return response()->json($response, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }



    public function getServiceList()
    {

        try {
            $data = Service::where('status', 1)->get();
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }




    public function sendContact(Request $request)
    {

        // dd($request->all());
        $validator = Validator::make($request->all(), [
            'name'             => 'required',
            'email'            => 'required',
            'subject'          => 'required',
            'message'          => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        //Please add email qeue...

        return response()->json("Send mail", 200);
    }
}
