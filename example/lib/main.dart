import 'package:example/presentation/page/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'This is an example using KZ State Management',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'KZ State Management',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Homepage(),
      ),
    );
  }
}
