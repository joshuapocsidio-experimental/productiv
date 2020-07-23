import 'package:flutter/material.dart';

enum RoutineType {
  daily,
  weekly,
  monthly,
  yearly
}

class Routine
{
  String title;
  String description;
  RoutineType type;

  Routine({this.title, this.description, this.type});


}