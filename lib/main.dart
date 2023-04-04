import 'package:flutter/material.dart';
import 'pages/Y&Wpage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Builder(
      builder: (context) => Scaffold(
        //body: Chrono(),
        // body: TrainingApp(),
        body: YWWorkoutPage(),
      ),
    ),
  ));
}