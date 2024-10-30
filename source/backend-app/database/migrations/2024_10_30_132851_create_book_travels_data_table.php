<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('book_travels_data', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id'); // Assuming user_id is the ID of the user booking the travel
            $table->unsignedBigInteger('booking_id'); // Foreign key referencing book_travels_vehicle
            $table->string('date');
            $table->string('time');
            $table->decimal('total_price', 10, 2); // Define total_price with decimal type for precision
            $table->timestamps();

            // Set up foreign key relationship
            $table->foreign('booking_id')->references('id')->on('book_travels_vehicle')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('book_travels_data');
    }
};
