import 'dart:math';

import 'package:confetti_app/widgets/MathWidget.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  ConfettiController _confettiController = ConfettiController();

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
    return Scaffold(
      body: Stack(
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
      ),
    );
  }
}
