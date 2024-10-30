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
        Schema::create('book_hotels_data', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id'); // Foreign key for the user who booked
            $table->unsignedBigInteger('hotel_id'); // Foreign key for the booked hotel
            $table->string('room_type'); // Room type (single, double, family)
            $table->integer('days'); // Number of days booked
            $table->string('date'); // Booking date
            $table->decimal('total_price', 10, 2); // Total booking price

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('book_hotels_data');
    }
};
