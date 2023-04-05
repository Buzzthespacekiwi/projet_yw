import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';

List<Exercice> exerciseList = [
  Exercice(nom: 'Push ups', repetitions: 20, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Pseudo push ups', repetitions: 20, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'push up hold', duree: Duration(seconds: 35),icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Clap push ups', repetitions: 15, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),

];

Programme pushup_routine = Programme(
  titre: 'Push up Routine',
  repetitions: 2,
  exercices: exerciseList,
);
