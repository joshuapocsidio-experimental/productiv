import 'package:flutter/material.dart';
import 'package:productiv/controller/animation/AnimationHandler.dart';
import 'package:productiv/controller/animation/AnimationHandlerList.dart';
import 'package:productiv/controller/reminder/ReminderController.dart';
import 'package:productiv/model/auth/UserManager.dart';
import 'package:productiv/model/productivity/reminder/Reminder.dart';
import 'package:productiv/model/productivity/reminder/ReminderList.dart';
import 'package:productiv/view/widget/button/EditTileButton.dart';
import 'package:productiv/view/widget/container/HoverContainer.dart';
import 'package:productiv/view/widget/popup/ReminderSnackBar.dart';
import 'package:provider/provider.dart';

class ReminderTile extends StatefulWidget {
  @override
  _ReminderTileState createState() => _ReminderTileState();
}

class _ReminderTileState extends State<ReminderTile> with TickerProviderStateMixin{
  Map<int, bool> statusMap;

  void initStatusMap(int count)
  {
    statusMap = new Map();

    for(int i = 0; i < count; i++)
    {
      statusMap[i] = false;
    }
  }

  void _mouseHovering(bool isHovering, int index)
  {
    setState(() {
      statusMap[index] = isHovering;
    });
  }

  @override
  void initState() {
    super.initState();
    initStatusMap(Provider.of<ReminderController>(context, listen: false).getListSize());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemCount: Provider.of<ReminderController>(context).getListSize(),
          separatorBuilder: (BuildContext separatorContext, int index) => const Divider(),
          itemBuilder: (BuildContext tileContext, int index) {
            // Get reminder attributes
            Reminder reminder = Provider.of<ReminderController>(context, listen: false).getReminderAt(index);
            bool reminderStatus = reminder.isDone;
            String reminderDescription = reminder.description;

            // Get Animation handlers
            AnimationController controller = AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 250),
            );

            Animation<double> animation = CurvedAnimation(
              parent: controller,
              curve: Curves.fastOutSlowIn,
            );

            // Get Hover Status
            bool hoverStatus = statusMap[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HoverContainer(
                  onHover: (value)
                  {
                    _mouseHovering(value, index);
                  },
                  child: Material(
                    elevation: 20,
                    child: CheckboxListTile(
                      title: Text(reminder.title),
                      secondary: IntrinsicWidth(
                        child: Row(
                          children: [
                            HoverContainer(
                              hoverColor: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              onTap: (){
                                controller.status == AnimationStatus.dismissed ? controller.forward() : controller.reverse();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.expand_more,
                                  size: 25,
                                  color: hoverStatus == true ? Colors.blue : null,
                                ),
                              ),
                            ),
                            Provider.value(
                                value: hoverStatus,
                                child: EditTileButton(
                                  lone: false,
                                  icon: Icons.edit,
                                  iconColor: Colors.green,
                                ),
                            ),
                            Provider.value(
                              value: hoverStatus,
                              child: EditTileButton(
                                lone: false,
                                icon: Icons.attach_file,
                                iconColor: Colors.purpleAccent,
                              ),
                            ),
                            Provider.value(
                              value: hoverStatus,
                              child: EditTileButton(
                                lone: false,
                                icon: Icons.delete_outline,
                                iconColor: Colors.redAccent,
                                onTap: () async {
                                  ReminderController controller = Provider.of<ReminderController>(context, listen: false);

                                  // First obtain the document ID
                                  String docID = controller.getReminderAt(index).getID();
                                  print("DELETE : $docID");
                                  // Remove reminder from local data
                                  controller.removeReminderAt(index);

                                  // Remove reminder from cloud data
                                  await Provider.of<UserManager>(context, listen: false).removeReminderFromFireStore(docID: docID);

                                  // Show popup to notify user of success
                                  ReminderSnackBar reminderSnackBar = new ReminderSnackBar(Colors.redAccent, "Reminder", "Successfully Removed!");
                                  reminderSnackBar.showNotification(this.context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      value: reminderStatus,
                      onChanged: (bool value) {
                        setState(() {
                          reminder.isDone = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ),
                Material(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100, bottom: 10),
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: animation,
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(reminderDescription),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
