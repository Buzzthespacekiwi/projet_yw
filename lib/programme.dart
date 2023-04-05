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
  bool _isFinished = false;
  bool _showRestScreen = false;
  bool _showEndOfRepetitionScreen = false;

  void _nextExercice() {
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

  Widget _buildEndOfRepetitionScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Fin de la répétition',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _startNextRepetition();
                },
                icon: const Icon(Icons.double_arrow),
                iconSize: 48,
              ),
              const SizedBox(width: 20),
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
        ],
      ),
    );
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
                      Text(
                        '${exercice.repetitions} Répétitions ',
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
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    exercice.video,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Bouton validation
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
                : const SizedBox.shrink(),
          ],
        ),
      ),
    ],
    ),
    );
  }
}








