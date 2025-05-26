<?php

namespace App\Utils;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;
use Intervention\Image\Drivers\Imagick\Driver;
use Intervention\Image\Drivers\Imagick\Encoders\JpegEncoder;
use Intervention\Image\Drivers\Imagick\Encoders\PngEncoder;
use Intervention\Image\Drivers\Imagick\Encoders\WebpEncoder;
use Intervention\Image\ImageManager;

class FileUtil
{
	public static function upload(UploadedFile $uploadedFile, float $scale, float $quality): array
	{
		$file = Storage::put(date('Ymd'), $uploadedFile);
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

		return [
			'file' => $file,
			'url' => $url,
			'file_name' => $image->exif('FILE.FileName'),
			'file_size' => $image->exif('FILE.FileSize'),
			'mime_type' => $image->exif('FILE.MimeType'),
			'height' => $image->exif('COMPUTED.Height'),
			'width' => $image->exif('COMPUTED.Width'),
		];
	}

	public static function delete(string $file): bool
	{
		return Storage::delete($file);
	}
}