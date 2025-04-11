<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Inertia\Response;
use Intervention\Image\Drivers\Gd\Driver;
use Intervention\Image\ImageManager;

class FileController extends Controller
{
	public function store(Request $request): Response
	{
		$request->validate([
			'file' => ['image', 'max:20480'],
		]);

		$file = Storage::put('', $request->file);
		$path = Storage::path($file);
		$url = Storage::url($file);

		$manager = new ImageManager(new Driver());
		$image = $manager->read($path);
		$image->scaleDown($image->width() * (int) $request->input('scale') / 100);
		$image->toJpeg((int) $request->input('quality'));
		$image->save($path);

		return Inertia::render('Upload', [
			'url' => $url,
			'image' => $image,
		]);
	}
}
