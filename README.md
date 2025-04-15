### kecilin

Ngecilin gambar-gambar yang besar.


#### Using curl

```
curl -F "file=@/path/to/image.jpg" \
	-F "scale=100" \
	-F "quality=76" https://kecilin.sintaks.web.id/api/upload
```

Sample result:

```
{
  "file": "20250415/yd11HRxAp2eTPum5tCTAeNO1pJjhD7Z8wNu6kIoq.jpg",
  "url": "https://kecilin.sintaks.web.id/storage/20250415/yd11HRxAp2eTPum5tCTAeNO1pJjhD7Z8wNu6kIoq.jpg",
  "file_name": "yd11HRxAp2eTPum5tCTAeNO1pJjhD7Z8wNu6kIoq.jpg",
  "file_size": 1362087,
  "mime_type": "image/jpeg",
  "height": 4608,
  "width": 3456
}
```