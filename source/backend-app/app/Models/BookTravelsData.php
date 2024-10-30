<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BookTravelsData extends Model
{
    use HasFactory;

    protected $table = 'book_travels_data';

    protected $fillable = [
        'user_id',
        'booking_id',
        'date',
        'time',
        'total_price',
    ];

    // Define the relationship with the book_travels_vehicle table
    public function booking()
    {
        return $this->belongsTo(BookTravelsVehicle::class, 'booking_id');
    }

    // Define the relationship with the User model (assuming you have a User model)
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
