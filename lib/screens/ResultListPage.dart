import 'package:confetti_app/providers/ResultListProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultListPage extends StatefulWidget {
  @override
  _ResultListPageState createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  ResultListProvider resultListProvider;

  @override
  void initState() {
    resultListProvider =
        Provider.of<ResultListProvider>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> generateList(double width) {
    final List<Widget> list =
        List<Widget>.generate(resultListProvider.getResultList.length, (index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
          width: width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: resultListProvider.getResultList[index].isCorrect
                ? Colors.green[200]
                : Colors.red[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(resultListProvider.getResultList[index].firstNumber
                        .toString()),
                    Text(resultListProvider.getResultList[index].secondNumber
                        .toString()),
                    Text(resultListProvider
                            .getResultList[index].selectedProcess +
                        '  ---------'),
                    Text(resultListProvider.getResultList[index].response),
                  ],
                ),
                Column(
                  children: [
                    Text(resultListProvider.getResultList[index].correctAnswer),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result List'),
        backgroundColor: Colors.purple[300],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Center(
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Column(
                          children: generateList(width),
                        ),
                        // Listenin en aşağısını daha rahat görebilmek için.
                        Container(
                          height: 200,
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
