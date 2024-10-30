<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BookTravelsVehicle extends Model
{
    use HasFactory;

    protected $table = 'book_travels_vehicle';

    protected $fillable = [
        'vehicle_name',
        'place',
        'price',
    ];
}
