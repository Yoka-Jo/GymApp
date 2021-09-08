import 'package:flutter/material.dart';

class ExerciseTypeModel {
  String title;
  String createdAt;

  ExerciseTypeModel({
    @required this.title,
    @required this.createdAt,
  });

  ExerciseTypeModel.fromJson(Map<String , dynamic> json){
    title = json["title"];
    createdAt = json["createdAt"];
  }
  
  Map<String , dynamic> toMap(){
    return {
      "title":title,
      "createdAt":createdAt,
    };
  }
}
