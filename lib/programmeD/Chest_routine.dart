import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';

List<Exercice> exerciseList = [
  Exercice(nom: 'Wide push ups', repetitions: 10, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Decline push ups', repetitions: 8, icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
  Exercice(nom: 'Dips', repetitions: 5,icone: "assets/images/pompes.png", video: "assets/video/pompes.gif"),
];

Programme chest_routine = Programme(
  titre: 'Chest routine',
  repetitions: 3,
  exercices: exerciseList,
  images: [
    "assets/images/pec.jpg",
  ],
  description: 'ce programme va vous permettre de développer vos pec ',
);
