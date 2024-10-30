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
        Schema::create('book_travels_vehicle', function (Blueprint $table) {
            $table->id();
            $table->string('vehicle_name');
            $table->string('place');
            $table->decimal('price', 8, 2); // Assuming price is in decimal format
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('book_travels_vehicle');
    }
};
