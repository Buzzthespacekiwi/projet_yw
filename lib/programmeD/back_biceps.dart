import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';

List<Exercice> exerciseList = [
  Exercice(nom: 'pull ups', repetitions: 3, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'incline chin ups', repetitions: 7, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Chin ups', repetitions: 4,icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
];

Programme back_biceps = Programme(
  titre: 'Back biceps',
  repetitions: 4,
  exercices: exerciseList,
);
