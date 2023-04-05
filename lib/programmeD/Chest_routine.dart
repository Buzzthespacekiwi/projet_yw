import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';

List<Exercice> exerciseList = [
  Exercice(nom: 'pull ups', repetitions: 10, icone: "assets/images/traction.png", video: "assets/video/traction.gif"),
  Exercice(nom: 'push ups', repetitions: 8, icone: "assets/images/pompes.png", video: "assets/video/pompe2.gif"),
  Exercice(nom: 'Dips', repetitions: 5,icone: "assets/images/dips.png", video: "assets/video/dips3.gif"),
  Exercice(nom: 'Gainage', duree: Duration(seconds: 10),icone: "assets/images/pompes.png", video: "assets/video/gainage.jpg"),

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
