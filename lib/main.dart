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
  ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
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
        Align(
          alignment: Alignment.topCenter,
          child: MathWidget(
            confettiController: _confettiController,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            emissionFrequency: 1,
            numberOfParticles: 5,
            maxBlastForce: 2,
            minBlastForce: 1,
            blastDirectionality: BlastDirectionality.directional,
            blastDirection: -pi / 2,
            gravity: 0.05,
            shouldLoop: false,
            displayTarget: false,
            colors: null,
            minimumSize: const Size(20, 10),
            maximumSize: const Size(30, 15),
            particleDrag: 0.05,
            canvas: MediaQuery.of(context).size,
            child: null,
          ),
        ),
      ],
    );
  }
}
