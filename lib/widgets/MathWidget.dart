import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class MathWidget extends StatefulWidget {
  const MathWidget({
    Key key,
    @required this.confettiController,
  }) : super(key: key);

  final ConfettiController confettiController;
  @override
  _MathWidgetState createState() => _MathWidgetState();
}

class _MathWidgetState extends State<MathWidget> {
  final _formKey = GlobalKey<FormState>();
  final responseController = TextEditingController();
  CountDownController countDownController = CountDownController();
  int duration = 10;

  final processList = ['+', '-', 'x', '÷'];
  String selectedProcess = '+';

  double firstNumber = 10;
  double secondNumber = 10;

  String errorMessage = '';

  int selectedLevel = 1;
  bool isStarted = false;
  @override
  void initState() {
    super.initState();

    //setScreen(selectedLevel);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    responseController.dispose();

    super.dispose();
  }

  void setScreen(int i) {
    setSelectedProcess();
    setFirstNumber(i);
    setSecondNumber(i);
    cleanResponse();
    startTimer();
  }

  void setSelectedProcess() {
    setState(() {
      selectedProcess = processList[Random().nextInt(processList.length)];
    });
  }

  void setFirstNumber(int i) {
    setState(() {
      firstNumber = getNumber(i);
    });

    setState(() {
      firstNumber = analyzeLevel(i, firstNumber);
    });
  }

  void setSecondNumber(int i) {
    setState(() {
      secondNumber = getNumber(i);
    });

    // Divide by zero issue!
    if (secondNumber == 0) {
      // Shuffle again! Performance!
      // setSecondNumber();
      // or, set '1'
      setState(() {
        secondNumber = 1;
      });
    }
    setState(() {
      secondNumber = analyzeLevel(i, secondNumber);
    });
  }

  double getNumber(int i) {
    double number = 1;
    if (i == 0) {
      number = Random().nextInt(10).toDouble();
    } else if (i == 1) {
      number = Random().nextInt(100).toDouble();
    } else if (i == 2) {
      number = Random().nextInt(1000).toDouble();
    }
    return number;
  }

  double analyzeLevel(int i, double number) {
    if (i == 1 && number < 10) {
      number += 10;
    } else if (i == 2 && number < 100) {
      number += 100;
    }
    return number;
  }

  void cleanResponse() {
    setState(() {
      responseController.text = '';
    });
  }

  void startTimer() {
    setState(() {
      errorMessage = '';
    });

    countDownController.restart(duration: duration);
    // _countDownController.
  }

  void setSelectedLevel(int i) {
    setState(() {
      selectedLevel = i;
    });
    setScreen(i);
  }

  void addDuration() {
    setState(() {
      duration += 2;
    });
  }

  List<InkWell> createLevelList() {
    // ignore: prefer_final_locals
    var inkWellList = <InkWell>[];
    final list = ['Easy', 'Medium', 'Hard'];
    print(list);

    list.asMap().forEach((index, value) {
      final inkWell = InkWell(
        onTap: () {
          setSelectedLevel(index);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: selectedLevel == index
                    ? [Colors.blue, Colors.blue[100]]
                    : [Colors.white, Colors.white]),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      return inkWellList.add(inkWell);
    });
    return inkWellList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: CircularCountDownTimer(
                    // Countdown duration in Seconds.
                    duration: duration,

                    // Countdown initial elapsed Duration in Seconds.
                    initialDuration: 0,

                    // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                    controller: countDownController,

                    // Width of the Countdown Widget.
                    width: MediaQuery.of(context).size.width / 8,

                    // Height of the Countdown Widget.
                    height: MediaQuery.of(context).size.height / 8,

                    // Ring Color for Countdown Widget.
                    ringColor: Colors.grey[300],

                    // Ring Gradient for Countdown Widget.
                    ringGradient: null,

                    // Filling Color for Countdown Widget.
                    fillColor: Colors.purpleAccent[100],

                    // Filling Gradient for Countdown Widget.
                    fillGradient: null,

                    // Background Color for Countdown Widget.
                    backgroundColor: Colors.purple[500],

                    // Background Gradient for Countdown Widget.
                    backgroundGradient: null,

                    // Border Thickness of the Countdown Ring.
                    strokeWidth: 8.0,

                    // Begin and end contours with a flat edge and no extension.
                    strokeCap: StrokeCap.round,

                    // Text Style for Countdown Text.
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    ),

                    // Format for the Countdown Text.
                    textFormat: CountdownTextFormat.S,

                    // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                    isReverse: true,

                    // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                    isReverseAnimation: false,

                    // Handles visibility of the Countdown Text.
                    isTimerTextShown: true,

                    // Handles the timer start.
                    autoStart: false,

                    // This Callback will execute when the Countdown Starts.
                    onStart: () {
                      // Here, do whatever you want
                      print('Countdown Started');
                    },

                    // This Callback will execute when the Countdown Ends.
                    onComplete: () {
                      // Here, do whatever you want
                      print('Countdown Ended');
                      setScreen(selectedLevel);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 36,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: createLevelList(),
                  ),
                ),
              ),
              isStarted
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              firstNumber.toStringAsFixed(0).toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              secondNumber.toStringAsFixed(0).toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selectedProcess,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    // decoration: TextDecoration.underline,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  '___________________',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: TextFormField(
                            controller: responseController,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.
                                if (checkResult()) {
                                  widget.confettiController.play();
                                  Scaffold.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Congrats!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );

                                  addDuration();
                                  setScreen(selectedLevel);
                                } else {
                                  // return error!
                                  setState(() {
                                    errorMessage = 'Try again!';
                                  });
                                }
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Check',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  errorMessage,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    // decoration: TextDecoration.underline,
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: selectedProcess == '÷'
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: const Text(
                                    '* Rounding floor to 2 decimal places accepted.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : Container(),
                        )
                      ],
                    )
                  : Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isStarted = true;
                            });
                            setScreen(selectedLevel);
                          },
                          child: const Center(
                            child: Text(
                              'Start',
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  bool checkResult() {
    double result = 0;
    var response = responseController.text;

    if (selectedProcess == '+') {
      result = firstNumber + secondNumber;
    } else if (selectedProcess == '-') {
      result = firstNumber - secondNumber;
    } else if (selectedProcess == 'x') {
      result = firstNumber * secondNumber;
    } else if (selectedProcess == '÷') {
      result = firstNumber / secondNumber;
    }

    String resultAsString = result.toStringAsFixed(2);

    if (response != null && response.contains(',')) {
      response = response.replaceAll(',', '.');
    } else if (response != null && response.contains('.')) {
      // resultAsString = resultAsString.replaceAll('.0', '.00');
    } else {
      response += '.00';
    }

    if (resultAsString != null && resultAsString.endsWith('.0')) {
      resultAsString = resultAsString.replaceAll('.0', '.00');
    } else if (resultAsString != null && resultAsString.endsWith('.00')) {
      // resultAsString = resultAsString.replaceAll('.0', '.00');
    } else if (resultAsString != null && resultAsString.contains('.')) {
      // resultAsString = resultAsString.replaceAll('.0', '.00');
    } else {
      resultAsString += '.00';
    }

    if (resultAsString == response) {
      return true;
    }

    return false;
  }
}
