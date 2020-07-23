import 'package:flutter/material.dart';
import 'package:productiv/src/model/productivity/reminder/Reminder.dart';
import 'package:productiv/src/model/productivity/reminder/ReminderList.dart';

/// Layer to handle interaction between ReminderList<Reminder> model and GUI
class ReminderController extends ChangeNotifier
{
  ReminderList reminders;

  ReminderController(ReminderList reminders)
  {
    this.reminders = reminders;
  }

  void addReminder(Reminder reminder)
  {
    this.reminders.addReminder(reminder);
    notifyListeners();
  }

  void removeReminderAt(int index)
  {
    this.reminders.removeReminderAt(index);
    notifyListeners();
  }

  Reminder getReminderAt(int index)
  {
    return this.reminders.getReminderAt(index);
  }

  String getDocumentID(int index)
  {
    return this.reminders.getReminderAt(index).getID();
  }

  void setDocumentID(String docID, int index)
  {
    this.reminders.getReminderAt(index).assignID(id: docID);
  }

  int getListSize()
  {
    return this.reminders.getListSize();
  }

  void initReminderList(List<Reminder> reminders)
  {
    reminders.forEach((reminder) => this.addReminder(reminder));
  }
}