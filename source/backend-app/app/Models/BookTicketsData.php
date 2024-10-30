<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BookTicketsData extends Model
{
    use HasFactory;

    protected $table = 'book_tickets_data';

    protected $fillable = [
        'booking_id',
        'number_of_tickets',
        'total_price',
        'date',
    ];

    /**
     * Define relationship with BookTicket (if needed).
     */
    public function ticket()
    {
        return $this->belongsTo(BookTicket::class, 'booking_id');
    }
}
