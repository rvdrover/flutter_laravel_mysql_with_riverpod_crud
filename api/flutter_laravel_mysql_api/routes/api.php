<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EmpController;

Route::get('/emp', [EmpController::class, 'index']);
Route::post('/emp', [EmpController::class, 'store']);
Route::put('/emp/{id}', [EmpController::class, 'update']);
Route::delete('/emp/{id}', [EmpController::class, 'destroy']);
