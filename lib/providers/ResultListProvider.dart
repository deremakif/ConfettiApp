import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultListProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
