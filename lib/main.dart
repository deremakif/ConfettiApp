import 'package:ConfettiApp/screens/ExamPage.dart';
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
        body: ExamPage(),
      ),
    );
  }
}
