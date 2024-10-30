<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\BookTravelsVehicle;
use App\Models\BookTravelsData;
use App\Models\BookHotel;
use App\Models\BookHotelsData;
use Carbon\Carbon;
use App\Models\MobileUser;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class AppController extends Controller
{

    public function getPrice(Request $request)
    {
        $request->validate([
            'vehicle_name' => 'required|string',
            'place' => 'required|string',
        ]);
    
        $vehicleName = strtolower(str_replace(' ', '_', $request->vehicle_name)); // Normalize vehicle name
        $vehicle = BookTravelsVehicle::where('vehicle_name', $vehicleName)
            ->where('place', $request->place)
            ->first();
    
        if ($vehicle) {
            return response()->json([
                'booking_id' => $vehicle->id,
                'price' => $vehicle->price
            ], 200);
        } else {
            return response()->json(['error' => 'No price found for the selected vehicle and destination'], 404);
        }
    }

    public function storeBooking(Request $request)
    {
        // Validate request data
        $request->validate([
            'user_id' => 'required|integer',
            'booking_id' => 'required|integer',
            'date' => 'required',
            'time' => 'required', // Validate time as 12-hour format
            'total_price' => 'required|numeric'
        ]);
    
        // Convert 12-hour time format to 24-hour format
        $formattedTime = \Carbon\Carbon::createFromFormat('h:i A', $request->time)->format('H:i:s');
    
        // Create a new booking record
        $booking = new BookTravelsData([
            'user_id' => $request->user_id,
            'booking_id' => $request->booking_id,
            'date' => $request->date,
            'time' => $formattedTime, // Use the formatted time
            'total_price' => $request->total_price,
        ]);
    
        $booking->save();
    
        return response()->json([
            'message' => 'Booking confirmed successfully!',
            'data' => $booking
        ], 201);
    }


    public function getHotelsByDistrict(Request $request)
    {
        $request->validate([
            'district' => 'required|string',
        ]);

        $hotels = BookHotel::where('place', $request->district)->get(['id', 'hotel_name', 'price_single', 'price_double', 'price_family']);
        return response()->json($hotels);
    }


    public function storeHotel(Request $request)
    {
        // Validate the incoming data
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|integer',
            'hotel_id' => 'required|integer',
            'room_type' => 'required|string',
            'days' => 'required|integer',
            'date' => 'required|date',
            'total_price' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }

        // Store the booking data in the database
        $booking = BookHotelsData::create([
            'user_id' => $request->user_id,
            'hotel_id' => $request->hotel_id,
            'room_type' => $request->room_type,
            'days' => $request->days,
            'date' => $request->date,
            'total_price' => $request->total_price,
        ]);

        return response()->json(['message' => 'Booking confirmed successfully!', 'data' => $booking], 201);
    }
    

}
