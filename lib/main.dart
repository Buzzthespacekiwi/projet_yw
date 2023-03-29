import 'package:flutter/material.dart';
import 'package:projet_yw/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: HomePage(),
    );
  }
}

// Définition de l'interface utilisateur
class BeginnerPage extends StatefulWidget {
  List<Programme> programmes = initialiserProgrammesDebutant();

  @override
  BeginnerPageState createState() => BeginnerPageState();
}

class BeginnerPageState extends State<BeginnerPage> {
  Programme? programmeSelectionne;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF79021D),
      appBar: AppBar(
        title: const Text("Programmes débutant",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Kontora',
        ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: widget.programmes.length,
        itemBuilder: (BuildContext context, int index) {
          Programme programme = widget.programmes[index];
          return ListTile(
            title: Text(programme.titre,
            style: const TextStyle(
              color : Colors.white,
              fontSize: 20,
              fontFamily: 'Kontora',
            ),
            ),
            onTap: (){
              setState(() {
                programmeSelectionne = programme;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(programme.titre),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          for(Exercice exercice in programme.exercices)
                            ListTile(
                              leading: Image.asset(exercice.icone),
                              title: Text(exercice.nom),
                              trailing: Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.black,
                                  shape: CircleBorder(),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text('${exercice.repetitions}x',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Kontora',
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Revenir à la liste'),
                        onPressed: (){
                          setState(() {
                            programmeSelectionne = null;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Valider'),
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:(BuildContext context) =>
                                  ProgrammePage(programme : programme),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Définition de l'interface utilisateur
class IntermediatePage extends StatefulWidget {
  List<Programme> programmes = initialiserProgrammesIntermediaire();

  @override
  IntermediatePageState createState() => IntermediatePageState();
}

class IntermediatePageState extends State<IntermediatePage>  {
  Programme? programmeSelectionne;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF79021D),
      appBar: AppBar(
        title: const Text("Programmes Intermédiaire",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Kontora',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: widget.programmes.length,
        itemBuilder: (BuildContext context, int index) {
          Programme programme = widget.programmes[index];
          return ListTile(
            title: Text(programme.titre),
            onTap: (){
              setState(() {
                programmeSelectionne = programme;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(programme.titre),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          for(Exercice exercice in programme.exercices)
                            ListTile(
                              leading: Image.asset(exercice.icone),
                              title: Text(exercice.nom),
                              trailing: Text('${exercice.repetitions}x'),
                            ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Revenir à la liste'),
                        onPressed: (){
                          setState(() {
                            programmeSelectionne = null;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Valider'),
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:(BuildContext context) =>
                                  ProgrammePage(programme : programme),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Définition de l'interface utilisateur
class ExpertPage extends StatefulWidget {
  List<Programme> programmes = initialiserProgrammesExpert();

  @override
  ExpertPageState createState() => ExpertPageState();
}

class ExpertPageState extends State<ExpertPage> {
  Programme? programmeSelectionne;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF79021D),
      appBar: AppBar(
        title: const Text("Programmes Expert",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Kontora',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: widget.programmes.length,
        itemBuilder: (BuildContext context, int index) {
          Programme programme = widget.programmes[index];
          return ListTile(
            title: Text(programme.titre),
            onTap: (){
              setState(() {
                programmeSelectionne = programme;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(programme.titre),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          for(Exercice exercice in programme.exercices)
                            ListTile(
                              leading: Image.asset(exercice.icone),
                              title: Text(exercice.nom),
                              trailing: Text('${exercice.repetitions}x'),
                            ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Revenir à la liste'),
                        onPressed: (){
                          setState(() {
                            programmeSelectionne = null;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Valider'),
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:(BuildContext context) =>
                                  ProgrammePage(programme : programme),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF79021D),
      body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)
                ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BeginnerPage()),
                    );
                  },
                  child:const Text("Parcours débutant",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Kontora',
                    color:Colors.white
                  ),
                  ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntermediatePage()),
                  );
                },
                child: const Text("Parcours intermédiaire",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Kontora',
                    color: Colors.white
                  ),
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black)
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExpertPage()),
                  );
                },
                child: const Text("Parcours expert",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Kontora',
                  color: Colors.white
                ),
                ),
              ),
            ],
          )
      )
    );
  }
}
