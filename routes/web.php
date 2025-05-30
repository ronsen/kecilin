<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get("/", [\App\Http\Controllers\HomeController::class, "index"])->name(
	"home"
);

Route::post("/kecilin", [
	\App\Http\Controllers\FileController::class,
	"store",
])->name("files.store");

Route::delete("/delete", [
	\App\Http\Controllers\FileController::class,
	"delete",
])->name("files.delete");
