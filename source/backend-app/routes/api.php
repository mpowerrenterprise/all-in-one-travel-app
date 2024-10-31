<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\UserController;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\AppController;

// Mobile Apps

Route::post('/login/mobile', [AuthController::class, 'login']);
Route::post('register/mobile', [AuthController::class, 'register']);
Route::get('/user/profile/mobile', [UserController::class, 'getProfile']);
Route::post('/user/change-password/mobile', [UserController::class, 'changePassword']);
Route::post('/get_price', [AppController::class, 'getPrice']);
Route::post('/confirm-booking', [AppController::class, 'storeBooking']);
Route::post('/hotels', [AppController::class, 'getHotelsByDistrict']);
Route::post('/confirm-booking/hotels', [AppController::class, 'storeHotel']);
Route::post('/tickets', [AppController::class, 'getTicketsByDistrict']);
Route::put('/book-tickets/{booking_id}', [AppController::class, 'insertTicketBooking']);
Route::get('/total-amount/{user_id}', [AppController::class, 'getTotalAmount']);
Route::get('/user-travels/{user_id}', [AppController::class, 'getUserTravels']);
