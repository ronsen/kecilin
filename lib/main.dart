import 'package:flutter/material.dart';
import 'package:kecilin/constants.dart';
import 'package:kecilin/home.dart';

void main() {
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
