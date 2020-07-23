import 'package:flutter/material.dart';

import 'ReminderTile.dart';

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
