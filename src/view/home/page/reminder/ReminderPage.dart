import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productiv/src/controller/reminder/ReminderController.dart';
import 'package:productiv/src/model/auth/UserManager.dart';
import 'package:productiv/src/model/productivity/reminder/ReminderList.dart';
import 'package:provider/provider.dart';
import 'ReminderBody.dart';
import 'ReminderHeader.dart';

class ReminderPage extends StatefulWidget
{
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage>{
  ReminderController reminderController;
  ReminderList reminderList;
  
  BottomSheet _bottomSheet;

  void populateFromDatabase() async
  {
    reminderController.initReminderList(await Provider.of<UserManager>(context, listen: false).fetchRemindersFromFirestore());
  }

  @override
  void initState() {
    super.initState();

    reminderList = new ReminderList();
    reminderController = new ReminderController(reminderList);

    populateFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReminderController>.value(
      value: reminderController,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(5),
          child: Material(
            elevation: 5,
            child: Column(
              children: [
                SizedBox(height: 10),
                ReminderHeader(),
                Divider(thickness: 1),
                ReminderBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}



//    showModalBottomSheet(
//      shape: ShapeBorder.,
//        context: this.context,
//        builder: (context){
//          return Container(
//            margin: EdgeInsets.all(100),
//            padding: EdgeInsets.all(100),
//            height: 500,
//            width: 100,
//            child: Center(
//              child: Text("BOTTOM SHEET TEST"),
//            )
//          );
//        });