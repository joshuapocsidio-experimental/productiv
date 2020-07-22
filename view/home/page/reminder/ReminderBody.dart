import 'package:flutter/material.dart';
import 'package:productiv/controller/animation/AnimationHandler.dart';
import 'package:productiv/controller/animation/AnimationHandlerList.dart';
import 'package:productiv/controller/reminder/ReminderController.dart';
import 'package:productiv/model/productivity/reminder/ReminderList.dart';
import 'package:productiv/model/productivity/reminder/ReminderListObserver.dart';
import 'package:productiv/view/home/page/reminder/ReminderTile.dart';
import 'package:provider/provider.dart';

class ReminderBody extends StatefulWidget
{
  @override
  _ReminderBodyState createState() => _ReminderBodyState();
}

class _ReminderBodyState extends State<ReminderBody> with TickerProviderStateMixin{


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ReminderTile();
  }
}
