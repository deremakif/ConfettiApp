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
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        firstNumber: json['firstNumber'] ?? json['firstNumber'],
        secondNumber: json['secondNumber'] ?? json['secondNumber'],
        selectedProcess: json['selectedProcess'] ?? json['selectedProcess'],
        response: json['response'] == null ? null : json['response'].toDouble(),
        correctAnswer: json['correctAnswer'] == null
            ? null
            : json['correctAnswer'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'firstNumber': firstNumber ?? firstNumber,
        'secondNumber': secondNumber ?? secondNumber,
        'selectedProcess': selectedProcess ?? selectedProcess,
        'response': response ?? response,
        'correctAnswer': correctAnswer ?? correctAnswer,
      };

  int firstNumber;
  int secondNumber;
  String selectedProcess;
  double response;
  double correctAnswer;
}
