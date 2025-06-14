import 'package:flutter/material.dart';
import 'package:clima_flutter/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.light(), home: LoadingScreen());
  }
}
