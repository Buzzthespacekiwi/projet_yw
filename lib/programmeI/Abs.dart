import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';

List<Exercice> exerciseList = [
  Exercice(nom: 'Half burpees', repetitions: 20, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Criss cross crunches', repetitions: 30, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Crunches', repetitions: 35,icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
];

Programme abs = Programme(
  titre: 'Abs',
  repetitions: 4,
  exercices: exerciseList,
);
