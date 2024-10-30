<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BookHotelsData extends Model
{
    use HasFactory;

    protected $table = 'book_hotels_data';

    // Define fillable fields
    protected $fillable = [
        'user_id',
        'hotel_id',
        'room_type',
        'days',
        'date',
        'total_price',
    ];

    // Define relationship to User model
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Define relationship to BookHotel model
    public function hotel()
    {
        return $this->belongsTo(BookHotel::class);
    }
}
