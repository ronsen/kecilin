import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:kecilin/about.dart';
import 'package:kecilin/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _selectedDirectory;
  bool _isProcessing = false;
  double _progress = 0.0;
  String _status = '';

  Future<void> _pickDirectory() async {
    String? result = await FilePicker.getDirectoryPath();
    if (result != null) {
      setState(() {
        _selectedDirectory = result;
        _status = '';
      });
    }
  }

  Future<void> _process(BuildContext context) async {
    if (_selectedDirectory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Select a folder to start resizing.')),
      );

      return;
    }

    if (await _requestPermission()) {
      setState(() {
        _isProcessing = true;
        _progress = 0.0;
        _status = 'Starting...';
      });

      try {
        final directory = Directory(_selectedDirectory!);
        final files = await directory.list().toList();
        final images = files.where((file) {
          final path = file.path.toLowerCase();
          return Constants.extensions.any(path.endsWith);
        }).toList();

        for (int i = 0; i < images.length; i++) {
          final file = images[i];
          final bytes = await (file as File).readAsBytes();
          final image = img.decodeImage(bytes);

          if (image != null) {
            if (image.width > Constants.width) {
              final resizedImage = img.copyResize(
                image,
                width: Constants.width,
              );
              final newFileName = file.path.split(Platform.pathSeparator).last;
              final newPath =
                  '${directory.path}${Platform.pathSeparator}$newFileName';
              await File(newPath).writeAsBytes(
                img.encodeJpg(resizedImage, quality: Constants.quality),
              );
            }
          }

          setState(() {
            _progress = (i + 1) / images.length;
            _status = 'Resizing ${file.path} ...';
          });
        }

        setState(() {
          _status = 'Resizing complete!';
        });
      } catch (e) {
        setState(() {
          _status = 'Error: $e';
        });
      } finally {
        setState(() {
          _isProcessing = false;
        });
      }
    } else {
      setState(() {
        _status = 'Storage permission denied.';
      });
    }
  }

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }

      return await Permission.storage.request().isGranted;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => About()));
            },
            icon: const Icon(Icons.question_mark),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                onPressed: _isProcessing ? null : _pickDirectory,
                child: Text(_selectedDirectory ?? 'Choose a folder'),
              ),
              const SizedBox(height: 20),
              if (_isProcessing)
                Column(
                  children: [
                    LinearProgressIndicator(value: _progress),
                    const SizedBox(height: 10),
                    Text(_status),
                  ],
                )
              else
                Text(_status),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isProcessing ? null : () => _process(context),
        child: Icon(Icons.start),
      ),
    );
  }
}
