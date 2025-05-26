<?php

namespace App\Http\Controllers;

use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;
use App\Utils\FileUtil;

class FileController extends Controller
{
	public function store(Request $request): Response
	{
		$request->validate([
			'file' => ['required', 'image', 'max:102400'],
		]);

		$scale = $request->input('scale') / 100;
		$quality = $request->input('quality') / 100;

		$result = FileUtil::upload($request->file, $scale, $quality);

		return Inertia::render('Upload', [
			'file' => $result['file'],
			'url' => $result['url'],
			'fileName' => $result['file_name'],
			'fileSize' => $result['file_size'],
			'mimeType' => $result['mime_type'],
			'height' => $result['height'],
			'width' => $result['width'],
		]);
	}

	public function delete(Request $request): RedirectResponse
	{
		if (FileUtil::delete($request->input('file'))) {
			return redirect('/')->with('message', 'File was successfully deleted from server.');
		} else {
			return redirect('/')->with('message', 'Something went wrong');
		}
	}
}
