<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Inertia\Response;
use Intervention\Image\Drivers\Imagick\Driver;
use Intervention\Image\Drivers\Imagick\Encoders\JpegEncoder;
use Intervention\Image\Drivers\Imagick\Encoders\PngEncoder;
use Intervention\Image\Drivers\Imagick\Encoders\WebpEncoder;
use Intervention\Image\ImageManager;

class FileController extends Controller
{
	public function store(Request $request): Response
	{
		$request->validate([
			'file' => ['image', 'max:20480'],
		]);

		$quality = (int) $request->input('quality');
		$scale = (int) $request->input('scale') / 100;

		$file = Storage::put(date('Ymd'), $request->file);
		$path = Storage::path($file);
		$url = Storage::url($file);
		$extension = File::extension($file);

		$manager = new ImageManager(new Driver());
		$image = $manager->read($path);
		$image->scaleDown(
			width: $image->width() * $scale,
			height: $image->height() * $scale,
		);
		
		$encoder = match ($extension) {
			'png' => new PngEncoder(),
			'webp' => new WebpEncoder(quality: $quality),
			default => new JpegEncoder(quality: $quality),
		};

		$image->encode($encoder)->save($path);

		$image = $manager->read($path); // reread

		return Inertia::render('Upload', [
			'file' => $file,
			'url' => $url,
			'fileName' => $image->exif('FILE.FileName'),
			'fileSize' => $image->exif('FILE.FileSize'),
			'mimeType' => $image->exif('FILE.MimeType'),
			'height' => $image->exif('COMPUTED.Height'),
			'width' => $image->exif('COMPUTED.Width'),
		]);
	}

	public function delete(Request $request): RedirectResponse
	{
		Storage::delete($request->input('file'));

		return redirect('/')->with('message', 'File was successfully deleted from server.');
	}
}
