import 'package:flutter/material.dart';
import '../pages/programList.dart';

List<Exercise> exerciseList = [
  Exercise(name: 'handstand push ups', sets: 3, reps: 12),
  Exercise(name: 'decline push ups', sets: 3, reps: 10),
  //Exercise(name: '', sets: 3, reps: 30),
];

Program epaule = Program(
  name: 'Epaule',
  repetitions: 4,
  exercises: exerciseList,
);
