import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projet_yw/exercice.dart';

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

  const ProgrammePage({super.key, required this.programme});

  @override
  _ProgrammePageState createState() => _ProgrammePageState();
}

class _ProgrammePageState extends State<ProgrammePage> {
  int _currentExerciceIndex = 0;
  int _totalRepetitions = 0;
  int _currentPauseSeconds = 30;
  bool _isPaused = false;
  bool _isFinished = false;
  bool _showRestScreen = false;
  late Timer _restTimer;

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

  void _nextExercice() {
    if (_currentExerciceIndex < widget.programme.exercices.length - 1) {
      setState(() {
        _currentExerciceIndex++;
        _currentPauseSeconds = 30;
        _showRestScreen = false;
      });
    } else {
      if (_totalRepetitions < widget.programme.repetitions - 1) {
        setState(() {
          _currentExerciceIndex = 0;
          _totalRepetitions++;
          _currentPauseSeconds = 30;
          _showRestScreen = false;
        });
      } else {
        setState(() {
          _isFinished = true;
        });
      }
    }
  }

  void _addPauseSeconds() {
    setState(() {
      _currentPauseSeconds += 5;
    });
  }

  Widget _buildPauseMenu(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context); // Retourne à la liste des programmes
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
      _isPaused = false;
    });
  }

  void _skipRest() {
    _restTimer.cancel();
    _nextExercice();
  }

  @override
  void dispose() {
    _restTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercice = widget.programme.exercices[_currentExerciceIndex];

    return Scaffold(
      body: _isFinished
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bravo vous avez terminé le programme!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Retour à la liste des programmes'),
            ),
          ],
        ),
      )
          : _showRestScreen
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Temps de repos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '$_currentPauseSeconds secondes restantes',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _addPauseSeconds(),
                  child: const Text('+5s'),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () => _skipRest(),
                  child: const Text('Passer le temps de repos'),
                ),
              ],
            ),
          ],
        ),
      )
          : Stack(
        children: [
          // Barre de progression
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: (_currentExerciceIndex +
                  _totalRepetitions /
                      widget.programme.repetitions) /
                  widget.programme.exercices.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          // Bouton pause
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: _isPaused
                ? GestureDetector(
              onTap: () => _resume(),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      exercice.nom,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pause de $_currentPauseSeconds secondes',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _addPauseSeconds(),
                          child: const Text('+5s'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _resume();
                            _nextExercice();
                          },
                          child: const Text('Exercice suivant'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox.shrink(),
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
                    child: Image.asset(
                      exercice.video,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Bouton validation
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      _showRestScreen = true;
                      _startRestTimer();
                      setState(() {});
                    },
                    child: const Text('Valider'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Initialisation de la liste de programmes
List<Programme> initialiserProgrammesDebutant() {
  List<Programme> programmes = [
    Programme(
      titre: 'Programme 1',
      repetitions: 2,
      exercices: [
        Exercice(
          nom: 'Traction à barre fixe',
          repetitions: 10,
          icone: 'assets/images/traction.png',
          video: 'assets/video/traction.gif',
        ),
        Exercice(
          nom: 'Dips',
          repetitions: 12,
          icone: 'assets/images/dips.png',
          video: 'assets/video/dips.gif',
        ),
        Exercice(
          nom : 'Pompes',
          repetitions: 10,
          icone: 'assets/images/pompes.png',
          video: 'assets/video/pompes.gif',
        )
      ],
    ),
    Programme(
      titre: 'Programme 2',
      repetitions: 3,
      exercices: [
        Exercice(
          nom: 'Exercice 1',
          repetitions: 8,
          icone: 'assets/images/pompes.png',
          video: 'assets/video/traction.gif',
        ),
        Exercice(
          nom: 'Exercice 3',
          repetitions: 15,
          icone: 'assets/images/dips.png',
          video: 'assets/video/dips.gif',
        ),
      ],
    ),
  ];
  return programmes;
}

// Initialisation de la liste de programmes
List<Programme> initialiserProgrammesIntermediaire() {
  List<Programme> programmes = [
    Programme(
      titre: 'Programme 1',
      repetitions: 2,
      exercices: [
        Exercice(
          nom: 'Traction à barre fixe',
          repetitions: 10,
          icone: 'assets/images/traction.png',
          video: 'assets/video/traction.gif',
        ),
        Exercice(
          nom: 'Dips',
          repetitions: 12,
          icone: 'assets/images/dips.png',
          video: 'assets/video/dips.gif',
        ),
        Exercice(
          nom : 'Pompes',
          repetitions: 10,
          icone: 'assets/images/pompes.png',
          video: 'assets/video/pompes.gif',
        )
      ],
    ),
    Programme(
      titre: 'Programme 2',
      repetitions: 3,
      exercices: [
        Exercice(
          nom: 'Exercice 1',
          repetitions: 8,
          icone: 'assets/images/pompes.png',
          video: 'assets/video/traction.gif',
        ),
        Exercice(
          nom: 'Exercice 3',
          repetitions: 15,
          icone: 'assets/images/dips.png',
          video: 'assets/video/dips.gif',
        ),
      ],
    ),
  ];
  return programmes;
}

// Initialisation de la liste de programmes
List<Programme> initialiserProgrammesExpert() {
  List<Programme> programmes = [
    Programme(
      titre: 'Programme 1',
      repetitions: 2,
      exercices: [
        Exercice(
          nom: 'Traction à barre fixe',
          repetitions: 10,
          icone: 'assets/images/traction.png',
          video: 'assets/video/traction.gif',
        ),
        Exercice(
          nom: 'Dips',
          repetitions: 12,
          icone: 'assets/images/dips.png',
          video: 'assets/video/dips.gif',
        ),
        Exercice(
          nom : 'Pompes',
          repetitions: 10,
          icone: 'assets/images/pompes.png',
          video: 'assets/video/pompes.gif',
        )
      ],
    ),
    Programme(
      titre: 'Programme 2',
      repetitions: 3,
      exercices: [
        Exercice(
          nom: 'Exercice 1',
          repetitions: 8,
          icone: 'assets/images/pompes.png',
          video: 'assets/video/traction.gif',
        ),
        Exercice(
          nom: 'Exercice 3',
          repetitions: 15,
          icone: 'assets/images/dips.png',
          video: 'assets/video/dips.gif',
        ),
      ],
    ),
  ];
  return programmes;
}





