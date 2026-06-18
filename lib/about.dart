import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('About')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text(
              'Kecilin',
              style: TextStyle(fontSize: 18, fontWeight: .bold),
            ),
            const SizedBox(height: 12),
            const Text('Resizing all images in a folder.'),
            const SizedBox(height: 48),
            const Text('Developed by:'),
            const SizedBox(height: 8),
            Link(
              target: LinkTarget.defaultTarget,
              uri: Uri.parse('https://ronsen.github.io'),
              builder: (context, followLink) => GestureDetector(
                onTap: followLink,
                child: const Text(
                  'Ronald Nababan',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
