import 'package:flutter/material.dart';
import '../pages/programList.dart';

List<Exercise> exerciseList = [
  Exercise(name: 'crunche', sets: 3, reps: 12),
  Exercise(name: 'dragon flag', sets: 3, reps: 10),
  Exercise(name: 'v sit ups', sets: 3, reps: 30),
];

Program abs = Program(
  name: 'Abs',
  repetitions: 4,
  exercises: exerciseList,
);
