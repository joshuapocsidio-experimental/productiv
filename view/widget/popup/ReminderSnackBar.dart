import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ReminderSnackBar extends StatelessWidget {
  final Color _backgroundColor;
  final String _title;
  final String _message;

  static Flushbar _flushBar;

  ReminderSnackBar(this._backgroundColor, this._title, this._message)
  {
    _flushBar = new Flushbar(
      backgroundColor: _backgroundColor != null ? _backgroundColor : Colors.blue,
      duration: Duration(seconds: 3),
      titleText: Text(
        _title != null ? _title : "",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
      messageText: Text(
        _title != null ? _message : "",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15
        ),
      ),
    );
  }

  void showNotification(BuildContext context)
  {
    _flushBar.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return _flushBar;
  }
}
