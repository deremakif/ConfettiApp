import 'package:ConfettiApp/widgets/CircularCountDownTimerWidget.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class LevelListWidget extends StatelessWidget {
  const LevelListWidget({
    Key key,
    @required this.duration,
    @required this.countDownController,
    @required this.selectedLevel,
    this.onComplete,
  }) : super(key: key);

  final int duration;
  final CountDownController countDownController;
  final int selectedLevel;
  final Function onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        alignment: Alignment.centerRight,
        child: CircularCountDownTimerWidget(
          duration: duration,
          countDownController: countDownController,
          selectedLevel: selectedLevel,
          onComplete: onComplete,
        ),
      ),
    );
  }
}
