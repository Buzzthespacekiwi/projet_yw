import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/Y&Wpage.dart';
import 'package:flutter/material.dart';
import 'pages/Chrono.dart';
import 'pages/programPage.dart';
import 'programmeD/pec.dart';

void main() {
  runApp(MaterialApp(
    home: Builder(
      builder: (context) => Scaffold(
        //body: Chrono(),
        // body: TrainingApp(),
        body: YWWorkoutPage(),
      ),
    ),
  ));
}