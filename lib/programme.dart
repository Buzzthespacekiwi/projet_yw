import 'package:flutter/material.dart';
import 'package:projet_yw/exercice.dart';
import 'dart:async';
import 'package:projet_yw/pages/Chrono.dart';

class Programme {
  final String titre;
  final int repetitions;
  final List<Exercice> exercices;
  final List<String>? images;
  final String? description;


  Programme({
    required this.titre,
    required this.repetitions,
    required this.exercices,
    this.images,
    this.description,
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
  bool _isFinished = false;
  bool _showRestScreen = false;
  bool _showEndOfRepetitionScreen = false;
  Timer? _exerciseTimer;
  Duration? _remainingTime;
  bool _showRepetitionsLeft = false;
  bool _showContinuePrompt = false;



  void _nextExercice() {
    if (widget.programme.exercices[_currentExerciceIndex].duree != null) {
      setState(() {
        _remainingTime = widget.programme.exercices[_currentExerciceIndex].duree;
      });
    }
    if (_currentExerciceIndex < widget.programme.exercices.length - 1) {
      setState(() {
        _showRestScreen = true;
      });
    } else {
      if (_totalRepetitions < widget.programme.repetitions - 1) {
        setState(() {
          _showEndOfRepetitionScreen = true;
        });
      } else {
        setState(() {
          _isFinished = true;
        });
      }
    }
  }

  void _startNextRepetition() {
    setState(() {
      _currentExerciceIndex = 0;
      _totalRepetitions++;
      _showEndOfRepetitionScreen = false;
    });
  }


  void _onChronoFinished() {
    setState(() {
      _showRestScreen = false;
      _currentExerciceIndex++;
    });
  }

  void _startExerciseTimer() {
    _remainingTime = widget.programme.exercices[_currentExerciceIndex].duree;
    _exerciseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime!.inSeconds == 1) {
          timer.cancel();
          _exerciseTimer = null;
          _nextExercice();
        } else {
          _remainingTime = _remainingTime! - const Duration(seconds: 1);
        }
      });
    });
  }

  void _pauseExerciseTimer() {
    setState(() {
      _exerciseTimer?.cancel();
      _exerciseTimer = null;
    });
  }


  Widget _buildExerciseTimerButton() {
    return Column(
      children: [
        Text(
          _remainingTime != null
              ? '${_remainingTime!.inMinutes.toString().padLeft(2, '0')}:${(_remainingTime!.inSeconds % 60).toString().padLeft(2, '0')}'
              : '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 42,
          ),
        ),
        if (_exerciseTimer == null || !_exerciseTimer!.isActive)
          IconButton(
            onPressed: () {
              _startExerciseTimer();
            },
            icon: const Icon(Icons.play_arrow),
            color: Colors.black,
            iconSize: 32,
          )
        else
          IconButton(
            onPressed: () {
              _pauseExerciseTimer();
            },
            icon: const Icon(Icons.pause),
            color: Colors.black,
            iconSize: 32,
          ),
      ],
    );
  }



  Widget _buildEndOfRepetitionScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_showRepetitionsLeft && !_showContinuePrompt)
            const Text(
              'Fin de la répétition',
              style: TextStyle(fontSize: 24),
            ),
          if (_showRepetitionsLeft)
            Text(
              'Il vous reste ${widget.programme.repetitions - _totalRepetitions} répétitions',
              style: const TextStyle(fontSize: 24),
            ),
          if (_showContinuePrompt)
            const Text(
              'Souhaitez-vous continuer?',
              style: TextStyle(fontSize: 24),
            ),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {
              if (!_showRepetitionsLeft) {
                setState(() {
                  _showRepetitionsLeft = true;
                });
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    _showContinuePrompt = true;
                  });
                });
              } else {
                _startNextRepetition();
              }
            },
            icon: const Icon(Icons.double_arrow),
            iconSize: 48,
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.stop),
            iconSize: 48,
          ),
        ],
      ),
    );
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
      Navigator.pop(context);

      },
      style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
      const Color(0xff92140C)),
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
          : _showEndOfRepetitionScreen
          ? _buildEndOfRepetitionScreen()
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
      widget.programme.repetitions) / widget.programme.exercices.length,
        backgroundColor: Colors.black,
        valueColor: const AlwaysStoppedAnimation<Color>(
            Color(0xff92140C)),
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
                      if (exercice.repetitions != null)
                        Text(
                          '${exercice.repetitions} Répétitions ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      if (exercice.duree != null)
                        Text(
                          'Durée: ${exercice.duree!.inSeconds} secondes',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),

                ],
              ),
            ),
            // Vidéo de l'exercice
            Expanded(
              child: Container(
                color: Colors.black,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    exercice.video,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
      // Bouton validation / chronomètre
      exercice.repetitions != null
          ? Container(
        padding: const EdgeInsets.all(16),
        child: IconButton(
          onPressed: () {
            _nextExercice();
            setState(() {});
          },
          icon: const Icon(Icons.double_arrow),
          color: Colors.black,
          iconSize: 32,
        ),
      )
          : Container(
        padding: const EdgeInsets.all(16),
        child: _buildExerciseTimerButton(),
      ),

    ],
        ),
      ),
    ],
    ),
    );
  }
}








