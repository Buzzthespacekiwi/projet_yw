import 'package:flutter/material.dart';
import '../pages/programList.dart';

List<Exercise> exerciseList = [
  Exercise(name: 'Squats', sets: 3, reps: 12),
  Exercise(name: 'Push-ups', sets: 3, reps: 10),
  Exercise(name: 'Plank', sets: 3, reps: 30),
];

Program pec = Program(
  name: 'Pec',
  repetitions: 3,
  exercises: exerciseList,
);

