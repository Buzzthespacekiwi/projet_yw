import 'package:flutter/material.dart';
import '../pages/programList.dart';

List<Exercise> exerciseList = [
  Exercise(name: 'Squats', sets: 3, reps: 12),
  Exercise(name: 'pistol squats', sets: 3, reps: 10),
  Exercise(name: 'squats saut', sets: 3, reps: 30),
];

Program jambes = Program(
  name: 'Jambes',
  repetitions: 6,
  exercises: exerciseList,
);
