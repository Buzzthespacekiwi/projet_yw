import 'package:flutter/material.dart';
import 'programList.dart';

class ProgramPage extends StatelessWidget {
  final Program program;

  ProgramPage({required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${program.repetitions} répétitions du circuit',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: program.exercises.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(program.exercises[index].name),
                  subtitle: Text('${program.exercises[index].sets} x ${program.exercises[index].reps}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Naviguer vers la page de l'exercice
              },
              child: Text('Commencer le programme'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff92140C)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
