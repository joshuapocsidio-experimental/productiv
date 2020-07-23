import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productiv/src/controller/reminder/ReminderController.dart';
import 'package:productiv/src/model/auth/UserManager.dart';
import 'package:productiv/src/model/colors/ColorPalette.dart';
import 'package:productiv/src/model/productivity/reminder/Reminder.dart';
import 'package:productiv/src/view/widget/popup/ReminderSnackBar.dart';
import 'package:provider/provider.dart';

class ReminderAddDialog extends StatefulWidget {
  final BuildContext parentContext;
  final double height;
  final double width;

  ReminderAddDialog({this.parentContext, this.height, this.width});

  @override
  _ReminderAddDialogState createState() => _ReminderAddDialogState();
}

class _ReminderAddDialogState extends State<ReminderAddDialog> {

  TextEditingController _labelController;
  TextEditingController _descriptionController;

  FocusNode titleFocusNode;
  FocusNode descFocusNode;

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
                    "Add Reminder",
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
                      onPressed: () async {
                        // Create reminder
                        String label = _labelController.text;
                        String description = _descriptionController.text;
                        Reminder reminder = new Reminder(title: label, description: description);

                        // Add to database and assign document id
                        String docID = await Provider.of<UserManager>(widget.parentContext, listen: false).addReminderToFirestore(reminder: reminder);
                        reminder.assignID(id: docID);
                        print("DOC ID : $docID");
                        // Add reminder into local data
                        ReminderController reminderController = Provider.of<ReminderController>(widget.parentContext, listen: false);
                        reminderController.addReminder(reminder);

                        // Pop dialog
                        Navigator.pop(this.context);

                        // Show bottom popup to notify success
                        ReminderSnackBar reminderSnackBar = new ReminderSnackBar(Colors.green, "Reminder", "Successfully Added!");
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
