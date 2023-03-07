import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomePage(),
    );
  }
}

class BeginnerPage extends StatelessWidget {
  const BeginnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Programmes débutant"),
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
      body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/zoro.jpg"),
              const Text("Roronoa Zoro",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Kontora'
                ),
                textAlign: TextAlign.center,
              ),
              const Text("Il faut se muscler les jambes pour devenir le meilleur",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Kontora'
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amberAccent)
                ),
                  onPressed: () => print("click btn"),
                  child:const Text("Parcours débutant",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Kontora',
                    color:Colors.black
                  ),
                  ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amberAccent)
                ),
                onPressed: () => print("click btn"),
                child: const Text("Parcours intermédiaire",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Kontora',
                    color:Colors.black
                  ),
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amberAccent)
                ),
                onPressed: () => print("click btn"),
                child: const Text("Parcours expert",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Kontora',
                  color:Colors.black
                ),
                ),
              ),
            ],
          )
      )
    );
  }
}
