import 'package:flutter/material.dart';
import 'package:workshop1/workshop1.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageCarousel(),
    );
  }
}