<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Emp extends Model
{
    protected $table = 'emps';
    protected $primaryKey = 'id';
    protected $fillable = ['firstname', 'lastname'];
}
