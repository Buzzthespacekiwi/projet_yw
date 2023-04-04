import 'dart:async';
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
  int _totalRepetitions = 0;
  int _currentPauseSeconds = 30;
  bool _isFinished = false;
  bool _showRestScreen = false;
  Timer? _restTimer;
  Timer? _durationTimer;
  int _currentExerciceRemainingTime = 0;

  void _startRestTimer() {
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentPauseSeconds > 0) {
        setState(() {
          _currentPauseSeconds--;
        });
      } else {
        timer.cancel();
        _nextExercice();
      }
    });
  }

  void _startDurationTimer() {
    final exercice = widget.programme.exercices[_currentExerciceIndex];
    if (exercice.duree != null) {
      setState(() {
        _currentExerciceRemainingTime = exercice.duree!.inSeconds;
      });

      _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_currentExerciceRemainingTime > 0) {
          setState(() {
            _currentExerciceRemainingTime--;
          });
        } else {
          timer.cancel();
          _showRestScreen = true;
          _startRestTimer();
        }
      });
    }
  }
  void _nextExercice() {
    if (_currentExerciceIndex < widget.programme.exercices.length - 1) {
      setState(() {
        _currentExerciceIndex++;
        _currentPauseSeconds = 30;
        _showRestScreen = false;
        _startDurationTimer();
      });
    } else {
      if (_totalRepetitions < widget.programme.repetitions - 1) {
        setState(() {
          _currentExerciceIndex = 0;
          _totalRepetitions++;
          _currentPauseSeconds = 30;
          _showRestScreen = false;
          _startDurationTimer();
        });
      } else {
        setState(() {
          _isFinished = true;
        });
      }
    }
  }


  Widget _buildPauseMenu(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Quitter le programme'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            _resume();
          },
          child: const Text('Reprendre'),
        ),
      ],
    );
  }

  void _pause() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pause'),
        content: _buildPauseMenu(context),
      ),
    );
  }

  void _resume() {
    setState(() {
    });
  }


  @override
  void initState() {
    super.initState();
    _startDurationTimer();
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    _durationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double textScaleFactor = screenWidth / 400;

    final exercice = widget.programme.exercices[_currentExerciceIndex];

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
              },
              child: Text(
                'Retour à la liste des programmes',
                style: TextStyle(fontSize: 16 * textScaleFactor),
              ),
            ),
          ],
        ),
      )
          : _showRestScreen
          ? const Center(
        child: Chrono()
      )
          : Stack(
        children: [
          // Barre de progression
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:Padding(
              padding: const EdgeInsets.only(bottom: 5), // Ajout d'une marge en bas
              child: Container(
                height: 10,
              child: LinearProgressIndicator(
                value: (_currentExerciceIndex +
                    _totalRepetitions /
                        widget.programme.repetitions) /
                    widget.programme.exercices.length,
                backgroundColor: Colors.black,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff92140C)),
                ),
              ),
            ),
          ),
          // Contenu de l'exercice
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // En-tête de l'exercice
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Image.asset(
                        exercice.icone,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercice.nom,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Répétition ${exercice.repetitions}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _pause(),
                        icon: const Icon(Icons.pause),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                // Vidéo de l'exercice
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: AspectRatio(
                      aspectRatio: 16 / 9, // Choisissez le ratio d'aspect approprié pour la vidéo
                      child: Image.asset(
                        exercice.video,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Bouton validation
                exercice.repetitions != null // Vérifier si l'exercice a des répétitions
                    ? Container(
                  padding: const EdgeInsets.all(16),
                  child: IconButton(
                    onPressed: () {
                      _showRestScreen = true;
                      _startRestTimer();
                      setState(() {});
                    },
                    icon: const Icon(Icons.double_arrow), // Utilisation de l'icône "flash_on"
                    color: Colors.black, // Changer la couleur de l'icône en blanc pour la rendre visible sur l'arrière-plan noir
                    iconSize: 32, // Ajuster la taille de l'icône si nécessaire
                  ),
                )
                    : const SizedBox.shrink(), // Ne pas afficher le bouton de validation pour les exercices avec durée
              ],
            ),
          ),
        ],
      ),
    );
  }
}






