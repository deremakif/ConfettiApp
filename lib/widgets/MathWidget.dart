import 'dart:math';

import 'package:confetti_app/models/ResultModel.dart';
import 'package:confetti_app/providers/ResultListProvider.dart';
import 'package:confetti_app/widgets/LevelListWidget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:provider/provider.dart';

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

  int firstNumber = 10;
  int secondNumber = 10;

  String errorMessage = '';

  int selectedLevel = 1;
  bool isStarted = false;
  String resultAsString = '';

  ResultListProvider resultListProvider;

  @override
  void initState() {
    resultListProvider =
        Provider.of<ResultListProvider>(context, listen: false);

    super.initState();

    //setScreen(selectedLevel);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    responseController.dispose();
    countDownController.pause();

    super.dispose();
  }

  bool checkResult() {
    double result = 0;
    var response = responseController.text;

    if (selectedProcess == '+') {
      result = double.parse((firstNumber + secondNumber).toString());
    } else if (selectedProcess == '-') {
      result = double.parse((firstNumber - secondNumber).toString());
    } else if (selectedProcess == 'x') {
      result = double.parse((firstNumber * secondNumber).toString());
    } else if (selectedProcess == '÷') {
      result = firstNumber / secondNumber;
    }

    resultAsString = result.toStringAsFixed(2);

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

    final ResultModel resultModel = ResultModel();
    resultModel.firstNumber = firstNumber;
    resultModel.secondNumber = secondNumber;
    resultModel.selectedProcess = selectedProcess;
    resultModel.correctAnswer = resultAsString;
    resultModel.response = response;

    if (resultAsString == response) {
      resultModel.isCorrect = true;
      addResultToList(resultModel);

      return true;
    } else {
      resultModel.isCorrect = false;

      addResultToList(resultModel);
      return false;
    }
  }

  dynamic addResultToList(ResultModel resultModel) {
    resultListProvider.addResultList(resultModel);
  }

  void checkResponse() {
    countDownController.pause();
    if (checkResult()) {
      widget.confettiController.play();
      ScaffoldMessenger.of(context).showSnackBar(
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

      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: true,
          title: 'Error',
          desc: 'Result: ' + resultAsString,
          btnOkOnPress: () {
            setScreen(selectedLevel);
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.purple[300])
        ..show();
    }
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

  int getNumber(int i) {
    int number = 1;
    if (i == 0) {
      number = Random().nextInt(10);
    } else if (i == 1) {
      number = Random().nextInt(100);
    } else if (i == 2) {
      number = Random().nextInt(1000);
    }
    return number;
  }

  int analyzeLevel(int i, int number) {
    if (i == 1 && number < 10) {
      number += 10;
    } else if (i == 2 && number < 100) {
      number += 100;
    }
    return int.parse(number.toString());
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
    final levelList = ['Easy', 'Medium', 'Hard'];
    print(levelList);

    levelList.asMap().forEach((index, value) {
      final inkWell = InkWell(
        onTap: () {
          setState(() {
            selectedLevel = index;
          });
          if (isStarted) {
            setSelectedLevel(index);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: selectedLevel == index
                    ? [Colors.purple[300], Colors.white]
                    : [Colors.white, Colors.white]),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
              LevelListWidget(
                duration: duration,
                countDownController: countDownController,
                selectedLevel: selectedLevel,
                onComplete: () {
                  checkResponse();
                },
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
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                            child: Text(
                              secondNumber.toStringAsFixed(0).toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                                  selectedProcess,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    // decoration: TextDecoration.underline,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
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
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple[300]),
                            ),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.
                                checkResponse();
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
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 36.0,
                            horizontal: 6,
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Navigate
                              countDownController.pause();
                              setState(() {
                                isStarted = false;
                              });

                              print('navigate');
                              Navigator.pushNamed(context, '/result-list-page');
                            },
                            child: const Center(
                              child: Text(
                                'Result List',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 66.0,
                          horizontal: 16,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple[300]),
                          ),
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
}
