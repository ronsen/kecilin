<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Utils\FileUtil;

class FileController extends Controller
{
	public function store(Request $request): JsonResponse
	{
		$request->validate([
			'file' => ['required', 'image', 'max:20480'],
		]);

		$scale = $request->input('scale') ? $request->input('scale') / 100 : 1;
		$quality = $request->input('quality') ? $request->input('quality') : 0.8;

		$result = FileUtil::upload($request->file, $scale, $quality);

		return response()->json($result);
	}
}
