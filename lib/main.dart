import 'package:flutter/material.dart';

void main() {
  runApp(const BingwaDataSwiftApp());
}

class BingwaDataSwiftApp extends StatelessWidget {
  const BingwaDataSwiftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BINGWA SOKONI DATA SWIFT',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BINGWA SOKONI DATA SWIFT'),
        ),
        body: const Center(
          child: Text('BINGWA SOKONI DATA SWIFT'),
        ),
      ),
    );
  }
}
