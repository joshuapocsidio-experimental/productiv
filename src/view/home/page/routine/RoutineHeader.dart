import 'package:flutter/material.dart';
import 'package:productiv/src/controller/routine/RoutineController.dart';
import 'package:productiv/src/model/colors/ColorPalette.dart';
import 'package:productiv/src/view/widget/container/HoverContainer.dart';

import 'RoutineAddDialog.dart';



class RoutineHeader extends StatefulWidget {

  final RoutineController routineController;

  RoutineHeader({this.routineController});

  @override
  _RoutineHeaderState createState() => _RoutineHeaderState();
}

class _RoutineHeaderState extends State<RoutineHeader>{

  bool _addHovering;

  void updateAddHovering(bool status)
  {
    setState(() {
      _addHovering = status;
    });
  }

  void showAddReminder()
  {
    showDialog(
        context: this.context,
        builder: (context)
        {
          double height = MediaQuery.of(this.context).size.height * 0.7;
          double width = MediaQuery.of(this.context).size.width * 0.7;

          return RoutineAddDialog(routineController: widget.routineController, height: height, width: width);
        }
    );
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
        title: Center(
          child: Text(
              "Routines",
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
            showAddReminder();
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
