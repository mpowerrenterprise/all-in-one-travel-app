<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BookHotel extends Model
{
    use HasFactory;

    protected $table = 'book_hotels';

    protected $fillable = [
        'hotel_name',
        'place',
        'price_single',
        'price_double',
        'price_family',
    ];
}
