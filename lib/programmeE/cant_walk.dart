import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';

List<Exercice> exerciseList = [
  Exercice(nom: 'Squats', repetitions: 35, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Pistol squats', repetitions: 15, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Squat jumps', repetitions: 25, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
];

Programme cant_walk = Programme(
  titre: 'Can\'t walk',
  repetitions: 4,
  exercices: exerciseList,
);
