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
import 'package:flutter/widgets.dart';

class Chrono extends StatefulWidget {
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
    const milliSec = const Duration(milliseconds: 1);
    _timer = new Timer.periodic(
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
            _fraction = (_counter * 100 + _milliseconds) / 3000.0;
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repos'),
        centerTitle: true,
        backgroundColor: Color(0xff92140C),

      ),
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
            SizedBox(height: 20.0),
            Text(
              timerString,
              style: TextStyle(
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
                    child: ImageIcon(
                      AssetImage('assets/images/MOINS.png'),
                      size: 24.0,
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.green,
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'add',
                  onPressed: _addTime,
                  tooltip: 'Plus',
                  child: ImageIcon(
                    AssetImage('assets/images/plus.png'),
                    size: 24.0,
                  ),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.green,
                ),
              ],
            )
        ),
      ),
    );
  }
}