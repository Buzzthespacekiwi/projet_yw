import 'package:flutter/material.dart';
import 'programPage.dart';
import '../programmeE/abdos.dart';
import '../programmeE/epaule.dart';


class ProgramListE extends StatefulWidget {
  @override
  _ProgramListEState createState() => _ProgramListEState();
}

class _ProgramListEState extends State<ProgramListE> {
  // final List<String> programs = ['pec', 'dos', 'biceps', 'triceps', 'jambes'];
  final List<ProgramPage> programs = [ProgramPage(program: abs), ProgramPage(program: epaule)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(programs[index].program.titre),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Color(0xff92140C),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(
                  Icons.description,
                  color: Colors.white,
                ),
              ),
            ),
            child: Card(
              child: ListTile(
                title: Text(programs[index].program.titre),
                leading: Icon(Icons.fitness_center),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProgramDescription(programs[index].program.titre),
                    ),
                  );
                },
              ),
            ),
            direction: DismissDirection.horizontal,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => programs[index],
                  ),
                );
                return false;
              }
            },
          );
        },
      ),
    );
  }
}

class ProgramDescription extends StatelessWidget {
  final String programName;

  ProgramDescription(this.programName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(programName),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('Description du programme $programName'),
        ),
      ),
    );
  }
}
