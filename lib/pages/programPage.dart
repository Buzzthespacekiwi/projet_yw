import 'package:flutter/material.dart';
import 'package:projet_yw/programme.dart';

class ProgramPage extends StatelessWidget {
  final Programme program;

  const ProgramPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program.titre),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${program.repetitions} répétitions du circuit',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: program.exercices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(program.exercices[index].nom),
                  subtitle: Text('${program.exercices[index].repetitions}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProgrammePage(programme: program),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff92140C)),
              ),
              child: const Text('Commencer le programme'),
            ),
          ),
        ],
      ),
    );
  }
}
