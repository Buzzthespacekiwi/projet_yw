import 'package:flutter/material.dart';
import '../pages/programList.dart';

List<Exercise> exerciseList = [
  Exercise(name: 'korean dips', sets: 3, reps: 12),
  Exercise(name: 'dips', sets: 3, reps: 10),
  Exercise(name: 'extention', sets: 3, reps: 30),
];

Program triceps = Program(
  name: 'Triceps',
  repetitions: 4,
  exercises: exerciseList,
);
