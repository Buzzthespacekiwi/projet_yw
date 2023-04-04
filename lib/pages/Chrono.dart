/*import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/Y&Wpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Builder(
      builder: (context) => Scaffold(
        body: YWWorkoutPage(),
      ),
    ),
  ));
}
*/import 'dart:async';
import 'package:flutter/material.dart';

class Chrono extends StatefulWidget {
  const Chrono({super.key});


  @override
  _ChronoState createState() => _ChronoState();
}

class _ChronoState extends State<Chrono> {

  int _counter = 30;
  Timer? _timer;
  double _fraction = 1.0;
  int _milliseconds = 0;

  String get timerString {
    int minutes = _counter ~/ 60;
    int seconds = _counter % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${_milliseconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const milliSec = Duration(milliseconds: 10);
    _timer = Timer.periodic(
      milliSec,
          (Timer timer) => setState(
            () {
          if (_counter < 1 && _milliseconds == 0) {
            timer.cancel();
          } else {
            if (_milliseconds == 0) {
              _counter -= 1;
              _milliseconds = 99;
            } else {
              _milliseconds -= 1;
            }
            _fraction = (_counter * 1000 + _milliseconds * 10) / 30000.0;
          }
        },
      ),
    );
  }

  void _addTime() {
    setState(() {
      if (_counter == 0 && _milliseconds == 0) {
        _counter = 10;
        _milliseconds = 0;
        _fraction = 1.0;
        _startTimer();
      } else {
        _counter += 10;
      }
    });
  }

  void _subtractTime() {
    setState(() {
      _counter -= 10;
      if (_counter < 0) {
        _counter = 0;
      }
    });
  }

  void _terminateChrono() {
    setState(() {
      _timer?.cancel();
      _counter = 0;
      _milliseconds = 0;
      _fraction = 0;
    });
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300.0,
              height: 300.0,
              child: CircularProgressIndicator(
                value: _fraction,
                strokeWidth: 8.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.lerp(Colors.white, Colors.green, _fraction)!,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              timerString,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: FloatingActionButton(
                    heroTag: 'subtract',
                    onPressed: _subtractTime,
                    tooltip: 'Moins',
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.green,
                    child: const ImageIcon(
                      AssetImage('assets/images/MOINS.png'),
                      size: 24.0,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _terminateChrono,
                  tooltip: 'Terminer',
                  icon: const Icon(Icons.double_arrow),
                  color: Colors.green,
                  iconSize: 48.0,
                ),
                FloatingActionButton(
                  heroTag: 'add',
                  onPressed: _addTime,
                  tooltip: 'Plus',
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.green,
                  child: const ImageIcon(
                    AssetImage('assets/images/plus.png'),
                    size: 24.0,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}