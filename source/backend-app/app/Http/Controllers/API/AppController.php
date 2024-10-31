<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\BookTravelsVehicle;
use App\Models\BookTravelsData;
use App\Models\BookHotel;
use App\Models\BookHotelsData;
use App\Models\BookTicket;
use App\Models\BookTicketsData;
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

    public function getTicketsByDistrict(Request $request)
    {

        $place = $request->input('place');

        
        // Fetch tickets based on the district (place) from the database
        $tickets = BookTicket::where('place', $place)
                          ->select('id', 'ticket_name', 'price')
                          ->get();

        return response()->json($tickets, 200);
    }


    public function insertTicketBooking(Request $request)
    {
        // Validate the incoming request data
        $validatedData = $request->validate([
            'user_id' => 'required', // Ensure user_id exists in users table
            'ticket_name' => 'required', // Ensure booking_id is provided
            'number_of_tickets' => 'required|integer|min:1',
            'total_price' => 'required|numeric|min:0',
            'date' => 'required',
        ]);

        // Insert a new booking record
        $ticketData = BookTicketsData::create([
            'user_id' => $validatedData['user_id'],
            'ticket_name' => $validatedData['ticket_name'],
            'number_of_tickets' => $validatedData['number_of_tickets'],
            'total_price' => $validatedData['total_price'],
            'date' => $validatedData['date'],
        ]);

        return response()->json([
            'message' => 'Booking created successfully',
            'data' => $ticketData,
        ], 200);
    }

    public function getTotalAmount($user_id)
    {

        // Fetch total amounts from each table
        $travelsTotal = BookTravelsData::where('user_id', $user_id)->sum('total_price');
        $hotelsTotal = BookHotelsData::where('user_id', $user_id)->sum('total_price');
        $ticketsTotal = BookTicketsData::where('user_id', $user_id)->sum('total_price');
    
        // Calculate grand total
        $grandTotal = $travelsTotal + $hotelsTotal + $ticketsTotal;
    
        return response()->json([
            'travelsTotal' => $travelsTotal,
            'hotelsTotal' => $hotelsTotal,
            'ticketsTotal' => $ticketsTotal,
            'grandTotal' => $grandTotal
        ]);
    }

    public function getUserTravels($user_id)
    {
        // Fetch all travel bookings for the user
        $travels = BookTravelsData::where('user_id', $user_id)
            ->get(['id', 'user_id', 'booking_id', 'date', 'time', 'total_price']);
    
        // Manually join related data for each travel booking
        $travels = $travels->map(function ($travel) {
            // Fetch the associated vehicle data using the booking_id
            $vehicle = BookTravelsVehicle::where('id', $travel->booking_id)->first();
    
            // Define a mapping for the vehicle names to human-readable text
            $vehicleNames = [
                '3_wheeler' => '3 Wheeler',
                'car' => 'Car',
                'van' => 'Van'
            ];
    
            return [
                'id' => $travel->id,
                'date' => $travel->date,
                'time' => $travel->time,
                'total_price' => $travel->total_price,
                'vehicle_name' => $vehicle ? ($vehicleNames[$vehicle->vehicle_name] ?? $vehicle->vehicle_name) : null,
                'place' => $vehicle ? $vehicle->place : null,
            ];
        });
    
        return response()->json($travels);
    }

    public function getUserHotels($user_id)
    {
        // Fetch all hotel bookings for the user with related hotel data
        $hotels = BookHotelsData::where('user_id', $user_id)
            ->get(['id', 'user_id', 'hotel_id', 'room_type', 'days', 'date', 'total_price']);

        // Attach hotel information (name and place) based on hotel_id
        $hotels = $hotels->map(function ($hotel) {
            $hotelDetails = BookHotel::where('id', $hotel->hotel_id)->first();

            return [
                'id' => $hotel->id,
                'date' => $hotel->date,
                'room_type' => ucfirst($hotel->room_type), // Capitalize room type for readability
                'days' => $hotel->days,
                'total_price' => $hotel->total_price,
                'hotel_name' => $hotelDetails ? $hotelDetails->hotel_name : null,
                'place' => $hotelDetails ? $hotelDetails->place : null,
            ];
        });

        return response()->json($hotels);
    }
    

}
