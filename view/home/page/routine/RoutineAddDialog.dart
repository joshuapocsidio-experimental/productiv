import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:productiv/controller/routine/RoutineController.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:productiv/model/productivity/routine/Routine.dart';
import 'package:productiv/view/widget/popup/ReminderSnackBar.dart';


class RoutineAddDialog extends StatefulWidget {

  final RoutineController routineController;
  final double height;
  final double width;

  RoutineAddDialog({this.routineController, this.height, this.width});

  @override
  _RoutineAddDialogState createState() => _RoutineAddDialogState();
}

class _RoutineAddDialogState extends State<RoutineAddDialog> {

  static List<String> routineTypeList;
  static String selectedRoutineType;

  List<String> dayList;
  List<String> monthList;
  String selectedMonth;
  int selectedDay;
  String selectedDayName;

  TextEditingController _labelController;
  TextEditingController _descriptionController;

  FocusNode titleFocusNode;
  FocusNode descFocusNode;

  FocusNode routineTypeNode;

  void updateTitleBox()
  {
    setState(() {
      print("debug");
    });
  }

  @override
  void initState() {
    super.initState();
    _labelController = new TextEditingController();
    _descriptionController = new TextEditingController();

    titleFocusNode = new FocusNode();
    titleFocusNode.addListener(() {updateTitleBox();});
    descFocusNode = new FocusNode();

    routineTypeNode = new FocusNode();

    routineTypeList = [
      "Daily",
      "Weekly",
      "Monthly",
      "Yearly",
    ];
    selectedRoutineType = routineTypeList[0];

    dayList = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    monthList = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    selectedDay = DateTime.now().day;
    selectedDayName = dayList[DateTime.now().weekday - 1];
    selectedMonth = monthList[DateTime.now().month - 1];

    print(selectedDay);
    print(selectedDayName);
    print(selectedMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Routine",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                    ),
                  ),
                  Tooltip(
                    message: "Test Message",
                    child: Icon(
                      Icons.info_outline,
                      color: primaryColor,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: secondaryColor,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isDense: true,
                        elevation: 10,
                        focusNode: routineTypeNode,
                        dropdownColor: secondaryColor,
                        focusColor: secondaryColor,
                        value: selectedRoutineType,
                        onTap: (){

                        },
                        onChanged: (value) {
                          setState(() {
                            selectedRoutineType = value;
                          });
                        },
                        items: routineTypeList.map<DropdownMenuItem<String>>(
                                (String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: routineTypeNode.hasFocus == true ? secondaryColor : Colors.white,
                                  ),
                                ),
                              );
                            }).
                        toList(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: FlatButton(
                      color: secondaryColor,
                      child: Text(
                        "Starting Date : $selectedMonth $selectedDay ($selectedDayName)",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        DateTime dt = await showDatePicker(
                            context: this.context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030));

                        setState(() {
                          selectedMonth = monthList[dt.month - 1];
                          selectedDayName = dayList[dt.weekday - 1];
                          selectedDay = dt.day;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1)
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: _labelController,
                maxLength: 50,
                textAlign: titleFocusNode.hasFocus == true ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  counter: SizedBox(height: 0, width: 0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: titleFocusNode.hasFocus == true ? "" : "Title",
                ),
                focusNode: titleFocusNode,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1)
                ),
                child: TextField(
                  controller: _descriptionController,
                  maxLength: 1000,
                  keyboardType: TextInputType.multiline,
                  minLines: 100,
                  maxLines: null,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Description",
                    labelStyle: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(right: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RaisedButton(
                      color: primaryColor,
                      onPressed: () {
                        String label = _labelController.text;
                        String description = _descriptionController.text;

                        Routine routine = new Routine(title: label, description: description, type: RoutineType.daily);
                        widget.routineController.addRoutine(routine);
                        Navigator.pop(this.context);

                        ReminderSnackBar reminderSnackBar = new ReminderSnackBar(Colors.green, "Routine", "Successfully Added!");
                        reminderSnackBar.showNotification(this.context);
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RaisedButton(
                      color: primaryColor,
                      onPressed: () {
                        Navigator.pop(this.context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
