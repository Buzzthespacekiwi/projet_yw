import 'package:flutter/material.dart';
import '../pages/programList.dart';

List<Exercise> exerciseList = [
  Exercise(name: 'curle', sets: 3, reps: 12),
  Exercise(name: 'chine-ups', sets: 3, reps: 10),
  Exercise(name: 'Push ups', sets: 3, reps: 30),
];

Program biceps = Program(
  name: 'Biceps',
  repetitions: 4,
  exercises: exerciseList,
);
