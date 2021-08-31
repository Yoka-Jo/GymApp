import 'package:flutter/cupertino.dart';

class ExerciseModel {
  String id;
  String muscle;
  String exerciseType;
  int setsNumber;
  List<dynamic> reps;
  List<dynamic> weights;
  double maxWeight;
  String exerciseTime;
  String pointTime;
  String calendarDate;


  ExerciseModel({
    @required this.id,
    @required this.muscle,
    @required this.exerciseType,
    @required this.setsNumber,
    @required this.reps,
    @required this.weights,
    @required this.maxWeight,
    @required this.exerciseTime,
    @required this.pointTime,
    @required this.calendarDate
  });

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    muscle = json["muscle"];
    exerciseType = json["exerciseType"];
    setsNumber = json["setsNumber"];
    reps = json["reps"];
    weights = json["weights"];
    maxWeight = json["maxWeight"];
    exerciseTime = json["exerciseTime"];
    pointTime = json["pointTime"];
    calendarDate = json["calendarDate"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id" : id,
      "muscle": muscle,
      "exerciseType": exerciseType,
      "setsNumber": setsNumber,
      "reps": reps,
      "weights": weights,
      "maxWeight": maxWeight,
      "exerciseTime": exerciseTime,
      "pointTime": pointTime,
      "calendarDate": calendarDate,
    };
  }
}
