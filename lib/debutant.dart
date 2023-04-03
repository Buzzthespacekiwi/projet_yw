import 'package:flutter/material.dart';
import 'package:projet_yw/programme.dart';
import 'package:projet_yw/exercice.dart';

class BeginnerPage extends StatefulWidget {
  List<Programme> programmes = initialiserProgrammesDebutant();

  BeginnerPage({super.key});

  @override
  BeginnerPageState createState() => BeginnerPageState();
}

class BeginnerPageState extends State<BeginnerPage> {
  Programme? programmeSelectionne;

  Widget buildProgrammePage(Programme programme) {
    return Scaffold(
      appBar: AppBar(
        title: Text(programme.titre),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Text(
            '${programme.repetitions} répétitions',
            style: const TextStyle(fontSize: 16),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: programme.exercices.length,
              itemBuilder: (BuildContext context, int index) {
                Exercice exercice = programme.exercices[index];
                return ListTile(
                  leading: Image.asset(exercice.icone),
                  title: Text(exercice.nom),
                  trailing: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.black,
                      shape: CircleBorder(),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '${exercice.repetitions}x',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Kontora',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ProgrammePage(programme: programme),
            ),
          );
        },
        child: const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF79021D),
      appBar: AppBar(
        // ...
      ),
      body: ListView.builder(
        itemCount: widget.programmes.length,
        itemBuilder: (BuildContext context, int index) {
          Programme programme = widget.programmes[index];
          return ListTile(
            title: Text(
              programme.titre,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Kontora',
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => buildProgrammePage(programme),
                ),
              );
            },
          );
        },
      ),
    );
  }
}