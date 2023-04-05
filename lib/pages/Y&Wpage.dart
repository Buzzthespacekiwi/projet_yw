import 'package:flutter/material.dart';
import 'homepage.dart';

class YWWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/baki.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Text(
                'Y & W',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0),
              Text(
                'WORKOUT',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainingApp(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Color(0xff92140C)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all(
                        Size(
                          MediaQuery.of(context).size.width * 0.25,
                          50,
                        ),
                      ),
                    ),
                    child: Text(
                      "Let's Go",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
