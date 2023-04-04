import 'package:flutter/material.dart';
import 'package:projet_yw/exercice.dart';
import 'package:projet_yw/programme.dart';


class ProgramDetails extends StatelessWidget {
  final Programme program;

  ProgramDetails({required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program.titre)
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Repetitions: ${program.repetitions}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: program.exercices.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(program.exercices[index].nom),
                  //subtitle: Text(program.exercises[index].description),
                  trailing: Text('${program.exercices[index].repetitions}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Lancer le programme
              },
              child: Text('Commencer le programme'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgramList extends StatelessWidget {
  final List<Programme> programs;

  ProgramList({required this.programs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
      ),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(programs[index].titre),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgramDetails(program: programs[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
