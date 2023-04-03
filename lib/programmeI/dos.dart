import 'package:flutter/material.dart';
import '../pages/programList.dart';

List<Exercise> exerciseList = [
  Exercise(name: 'large pull ups', sets: 3, reps: 12),
 // Exercise(name: 'chine-ups', sets: 3, reps: 10),
  Exercise(name: 'large Push ups', sets: 3, reps: 30),
];

Program dos = Program(
  name: 'Dos',
  repetitions: 4,
  exercises: exerciseList,
);
