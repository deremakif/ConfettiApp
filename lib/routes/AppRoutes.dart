import 'package:confetti_app/screens/ExamPage.dart';
import 'package:confetti_app/screens/ResultListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRoute {
  static dynamic getRoute() {
    return <String, WidgetBuilder>{
      '/exam-page': (context) => ExamPage(),
      '/result-list-page': (context) => ResultListPage(),
    };
  }

  static Future<String> getInitialRoute() async {
    return '/exam-page';
  }
}
