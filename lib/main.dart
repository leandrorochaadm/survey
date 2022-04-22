import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enquete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Text("home"),
    );
  }
}
