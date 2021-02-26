import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

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

  final processList = ['+', '-', 'x', '÷'];
  String selectedProcess = '+';

  double firstNumber = 10;
  double secondNumber = 10;

  String errorMessage = '';

  int selectedLevel = 1;
  @override
  void initState() {
    super.initState();
    setScreen(selectedLevel);
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

  void setSelectedLevel(int i) {
    setState(() {
      selectedLevel = i;
    });
    setScreen(i);
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
    return Container(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
