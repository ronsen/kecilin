<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Inertia\Response;

class FileController extends Controller
{
    public function store(Request $request): Response
	{
		$path = Storage::put('', $request->file);
		$url = Storage::url($path);

		return Inertia::render('Upload', [
			'url' => $url,
		]);
	}
}
