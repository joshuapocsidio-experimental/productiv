import 'package:flutter/material.dart';
import 'package:productiv/src/model/productivity/routine/Routine.dart';

import 'RoutineHeader.dart';

class RoutinePage extends StatefulWidget {
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
//
//  ReminderList _reminderList;
//  ReminderController _reminderController;

  @override
  void initState() {
    super.initState();

    Routine routine = new Routine(title: "Title", description: "Description", type: RoutineType.monthly);
//    _reminderList = new ReminderList();
//    _reminderController = new ReminderController(_reminderList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(5),
        child: Material(
          elevation: 5,
          child: Column(
            children: [
              SizedBox(height: 10),
              RoutineHeader(),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
