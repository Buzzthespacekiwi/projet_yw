import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';

List<Exercice> exerciseList = [
  Exercice(nom: 'curle', repetitions: 12, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'chine-ups', repetitions: 10, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Push ups', repetitions: 30,icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
];


Programme pec = Programme(
  titre: 'Pec',
  repetitions: 3,
  exercices: exerciseList,
);

