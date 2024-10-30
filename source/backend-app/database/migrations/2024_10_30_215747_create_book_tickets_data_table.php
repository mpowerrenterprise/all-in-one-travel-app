<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('book_tickets_data', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('booking_id');
            $table->integer('number_of_tickets'); // Number of tickets booked
            $table->decimal('total_price', 10, 2); // Total price of booking
            $table->string('date'); // Date of the booking
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('book_tickets_data');
    }
};
