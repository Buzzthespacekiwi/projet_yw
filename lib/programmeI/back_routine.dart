import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';

List<Exercice> exerciseList = [
  Exercice(nom: 'Wide pull ups', repetitions: 10, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Wide grip behind neck pull ups', repetitions: 10, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
];

Programme back_routine = Programme(
  titre: 'Back routine',
  repetitions: 4,
  exercices: exerciseList,
);
