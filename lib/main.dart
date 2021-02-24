import 'dart:math';

import 'package:ConfettiApp/widgets/MathWidget.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ConfettiSample());

class ConfettiSample extends StatelessWidget {
  const ConfettiSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Confetti',
        home: Scaffold(
          backgroundColor: Colors.grey,
          body: MyApp(),
        ));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConfettiController _controllerCenterLeft;

  @override
  void initState() {
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Align(
          alignment: Alignment.topCenter,
          child: MathWidget(),
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenterLeft,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.explosive,
            blastDirection: -pi / 2,

            emissionFrequency: 0.1,
            particleDrag: 0.05,
            minimumSize: const Size(
              10,
              10,
            ), // set the minimum potential size for the confetti (width, height)
            maximumSize: const Size(
              50,
              50,
            ), // set the maximum potential size for the confetti (width, height)
            numberOfParticles: 1,
            gravity: 0.1,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: FlatButton(
              onPressed: () {
                _controllerCenterLeft.play();
              },
              child: _display('singles')),
        ),
      ],
    );
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
