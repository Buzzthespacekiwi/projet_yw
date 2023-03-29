import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

class Exercice {
  final String nom;
  final int repetitions;
  final String icone; // Variable pour l'icone de l'exercice
  final String video;

  Exercice({
    required this.nom,
    required this.repetitions,
    required this.icone,
    required this.video,
  });
}

class ProgrammePage extends StatefulWidget {
  final Programme programme;

  ProgrammePage({required this.programme});

  @override
  _ProgrammePageState createState() => _ProgrammePageState();
}

class _ProgrammePageState extends State<ProgrammePage> {
  int _currentExerciceIndex = 0;
  int _currentRepetitionIndex = 0;
  int _currentPauseSeconds = 30;
  bool _isPaused = false;
  bool _isFinished = false;

  void _nextExercice() {
    if (_currentExerciceIndex < widget.programme.exercices.length - 1) {
      setState(() {
        _currentExerciceIndex++;
        _currentRepetitionIndex = 0;
        _currentPauseSeconds = 30;
        _isPaused = false;
      });
    } else {
      setState(() {
        _isFinished = true;
      });
    }
  }

  void _nextRepetition() {
    if (_currentRepetitionIndex < widget.programme.repetitions - 1) {
      setState(() {
        _currentRepetitionIndex++;
        _currentPauseSeconds = 30;
        _isPaused = false;
      });
    } else {
      _nextExercice();
    }
  }

  void _addPauseSeconds() {
    setState(() {
      _currentPauseSeconds += 5;
    });
  }

  void _pause() {
    setState(() {
      _isPaused = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercice = widget.programme.exercices[_currentExerciceIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.programme.titre),
      ),
      body: _isFinished
          ? const Center(  child: Text('Programme fini')
      )
          : Stack(
      children: [
      // Vidéo de fond de l'exercice
      Positioned.fill(
      child: Container(
      color: Colors.black,
      child: Image.asset(
        exercice.video,
        fit: BoxFit.cover,
      ),
    ),
    ),
    // Barre de progression
    Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: LinearProgressIndicator(
    value: (_currentExerciceIndex + _currentRepetitionIndex / widget.programme.repetitions) /
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
    onTap: () {
    setState(() {
    _isPaused = false;
    });
    },
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
                onPressed: () => _nextExercice(),
                child: const Text('Exercice suivant'),
              ),
            ],
          ),
        ],
      ),
    ),
    ): const SizedBox.shrink(),
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Répétition ${_currentRepetitionIndex + 1}/${widget.programme.repetitions}',
                          style: const TextStyle(
                            color: Colors.white,
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
                  onPressed: () => _nextRepetition(),
                  child: const Text('Exercice suivant'),
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





