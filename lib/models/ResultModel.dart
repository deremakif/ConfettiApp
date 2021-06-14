// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

ResultModel resultModelFromJson(String str) =>
    ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  ResultModel({
    this.firstNumber,
    this.secondNumber,
    this.selectedProcess,
    this.response,
    this.correctAnswer,
    this.isCorrect,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        firstNumber: json['firstNumber'] ?? json['firstNumber'],
        secondNumber: json['secondNumber'] ?? json['secondNumber'],
        selectedProcess: json['selectedProcess'] ?? json['selectedProcess'],
        response: json['response'] ?? json['response'],
        correctAnswer: json['correctAnswer'] ?? json['correctAnswer'],
        isCorrect: json['isCorrect'] ?? json['isCorrect'],
      );

  Map<String, dynamic> toJson() => {
        'firstNumber': firstNumber ?? firstNumber,
        'secondNumber': secondNumber ?? secondNumber,
        'selectedProcess': selectedProcess ?? selectedProcess,
        'response': response ?? response,
        'correctAnswer': correctAnswer ?? correctAnswer,
        'isCorrect': isCorrect ?? isCorrect,
      };

  int firstNumber;
  int secondNumber;
  String selectedProcess;
  String response;
  String correctAnswer;
  bool isCorrect;
}
