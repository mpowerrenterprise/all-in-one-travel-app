<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BookTicketsData extends Model
{
    use HasFactory;

    protected $table = 'book_tickets_data';

    protected $fillable = [
        'user_id',
        'ticket_name',
        'number_of_tickets',
        'total_price',
        'date',
    ];

}
