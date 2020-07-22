import 'package:flutter/material.dart';
import 'package:productiv/controller/reminder/ReminderController.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:productiv/view/widget/container/HoverContainer.dart';
import 'package:provider/provider.dart';

import 'ReminderAddDialog.dart';


class ReminderHeader extends StatefulWidget {

  @override
_ReminderHeaderState createState() => _ReminderHeaderState();
}

class _ReminderHeaderState extends State<ReminderHeader>{
  bool _addHovering;

  void updateAddHovering(bool status)
  {
    setState(() {
      _addHovering = status;
    });
  }

  @override
  void initState() {
    super.initState();

    _addHovering = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      child: ListTile(
        enabled: false,
        title: Center(
          child: Text(
              "Reminders",
              style: TextStyle(
                fontSize: 25,
                color: secondaryColor,
              )
          ),
        ),
        trailing: HoverContainer(
          borderRadius: BorderRadius.circular(100),
          onHover: (value){
            updateAddHovering(value);
          },
          onTap: (){
            showDialog(
              context: this.context,
              builder: (dialogContext)
              {
                double height = MediaQuery.of(this.context).size.height * 0.7;
                double width = MediaQuery.of(this.context).size.width * 0.7;

                return ReminderAddDialog(parentContext: context, height: height, width: width);
              }
          );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.add_box,
              size: 30,
              color: _addHovering == true ? Colors.green : null,
            ),
          ),
        ),
      ),
    );
  }
}
