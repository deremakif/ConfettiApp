import 'package:confetti_app/models/ResultModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultListProvider with ChangeNotifier {
  final List<ResultModel> _resultList = [];

  List<ResultModel> get getResultList => _resultList;

  void addResultList(ResultModel model) {
    _resultList.add(model);
    notifyListeners();
  }
}
