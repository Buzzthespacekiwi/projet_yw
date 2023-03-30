import 'package:flutter/material.dart';
import 'package:projet_yw/debutant.dart';
import 'package:projet_yw/intermediaire.dart';
import 'package:projet_yw/expert.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
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
