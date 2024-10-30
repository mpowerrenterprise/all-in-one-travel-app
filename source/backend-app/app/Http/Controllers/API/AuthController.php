<?php

namespace App\Http\Controllers\API;

use App\Models\MobileUser;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;


class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {
            // Validate request
            $request->validate([
                'full_name' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:mobile_users',
                'password' => 'required|string|min:8',
                'phone_number' => 'required|string|max:15|unique:mobile_users',
                'gender' => 'nullable|string|in:Male,Female',
                'dob' => 'required|date',
                'country' => 'nullable|string|max:255',
                'address' => 'nullable|string',
            ]);
    
    
            // Create mobile user
            $mobileUser = MobileUser::create([
                'full_name' => $request->full_name,
                'email' => $request->email,
                'password' => $request->password,
                'phone_number' => $request->phone_number,
                'gender' => $request->gender,
                'dob' => $request->dob,
                'country' => $request->country,
                'address' => $request->address,
            ]);
    
            // Return success response
            return response()->json([
                'message' => 'User registered successfully',
                'user' => $mobileUser,
            ], 201);
    
        } catch (\Exception $e) {
            // Return error response
            return response()->json([
                'error' => 'Registration failed',
                'message' => $e->getMessage(),
            ], 400);
        }
    }
    

    public function login(Request $request)
    {
        // Validate request data
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);
    
        // Attempt to find the user by email
        $user = MobileUser::where('email', $request->email)->first();
    
        // Check if the user exists and the plain-text password matches
        if ($user && $request->password === $user->password) {
            // Password matches; return success with selected user details
            return response()->json([
                'message' => 'Login successful',
                'data' => [
                    'id' => $user->id,
                    'email' => $user->email,
                    'full_name' => $user->full_name,
                ],
            ], 200);
        }
    
        // Invalid credentials
        return response()->json(['message' => 'Invalid credentials'], 401);
    }
    
    
   
}
