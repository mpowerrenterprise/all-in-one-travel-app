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
        Schema::create('book_hotels', function (Blueprint $table) {
            $table->id();
            $table->string('hotel_name');
            $table->string('place');
            $table->decimal('price_single', 8, 2); // Single room price
            $table->decimal('price_double', 8, 2); // Double room price
            $table->decimal('price_family', 8, 2); // Family room price
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('book_hotels');
    }
};
