import 'package:flutter/material.dart';
import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/pages/Chrono.dart';

class Programme {
  final String titre;
  final int repetitions;
  final List<Exercice> exercices;


  Programme({
    required this.titre,
    required this.repetitions,
    required this.exercices,
  });
}

class ProgrammePage extends StatefulWidget {
  final Programme programme;

  const ProgrammePage({Key? key, required this.programme}) : super(key: key);

  @override
  _ProgrammePageState createState() => _ProgrammePageState();
}

class _ProgrammePageState extends State<ProgrammePage> {
  int _currentExerciceIndex = 0;
  final int _totalRepetitions = 0;
  final bool _isFinished = false;
  bool _showRestScreen = false;



  void _onChronoFinished() {
    setState(() {
      _showRestScreen = false;
      _currentExerciceIndex++;
    });
  }






  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    double textScaleFactor = screenWidth / 400;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.programme.titre,
          style: TextStyle(fontSize: 18 * textScaleFactor),
        ),
      ),
      body: _isFinished
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bravo vous avez terminé le programme!',
              style: TextStyle(fontSize: 18 * textScaleFactor),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xff92140C),
                ),
              ),
              child: Text(
                'Retour à la liste des programmes',
                style: TextStyle(fontSize: 16 * textScaleFactor),
              ),
            ),
          ],
        ),
      )
          : _showRestScreen
          ? Center(child: Chrono(onFinished: _onChronoFinished))
          : Stack(
        children: [
          // Barre de progression
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SizedBox(
                height: 10,
                child: LinearProgressIndicator(
                  value: (_currentExerciceIndex +
                      _totalRepetitions /
                          widget.programme.repetitions) /
                      widget.programme.exercices.length,
                  backgroundColor: Colors.black,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xff92140C),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






