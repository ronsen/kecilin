import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:kecilin/constants.dart';
import 'package:kecilin/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux) {
    await windowManager.ensureInitialized();

    WindowOptions options = const WindowOptions(
      title: Constants.appName,
      center: true,
      size: Size(480, 720),
    );

    windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(brightness: .light),
      darkTheme: ThemeData(brightness: .dark),
      home: const Home(title: Constants.appName),
    );
  }
}
