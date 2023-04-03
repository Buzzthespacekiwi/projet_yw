import 'package:flutter/material.dart';


class Program {
  final String name;
  final int repetitions;
  final List<Exercise> exercises;

  Program({required this.name, required this.repetitions, required this.exercises});
}

class Exercise {
  final String name;
  //final String description;
  final int reps;
  final int sets;

  Exercise({required this.name, /*required this.description,*/ required this.reps, required this.sets});
}

class ProgramDetails extends StatelessWidget {
  final Program program;

  ProgramDetails({required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Repetitions: ${program.repetitions}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: program.exercises.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(program.exercises[index].name),
                  //subtitle: Text(program.exercises[index].description),
                  trailing: Text('${program.exercises[index].reps} x ${program.exercises[index].sets}'),
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
  final List<Program> programs;

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
            title: Text(programs[index].name),
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
