import 'Reminder.dart';
import 'ReminderListObserver.dart';

class ReminderList
{
  List<Reminder> _reminders;
  List<ReminderListObserver> _observers;

  ReminderList()
  {
    _reminders = new List();
    _observers = new List();
  }

  // Getters
  List<Reminder> getReminders()
  {
    return List.unmodifiable(_reminders);
  }

  Reminder getReminderAt(int index)
  {
    return _reminders.elementAt(index);
  }

  int getListSize()
  {
    return _reminders.length;
  }

  // Mutators
  void addReminder(Reminder reminder)
  {
    _reminders.add(reminder);
    notifyAddObservers();
  }

  void addReminders(List<Reminder> reminders)
  {
    _reminders.addAll(reminders);
    notifyAddObservers();
  }

  void removeReminderAt(int index)
  {
    _reminders.removeAt(index);
    notifyRemoveObservers(index);
  }

  // Initialize observers
  void addObserver(ReminderListObserver ob)
  {
    _observers.add(ob);
  }

  void notifyAddObservers()
  {
    for(int i = 0; i < _observers.length; i++)
    {
      _observers.elementAt(i).handleAddedReminder();
    }
  }

  void notifyRemoveObservers(int index)
  {
    for(int i = 0; i < _observers.length; i++)
    {
      _observers.elementAt(i).handleRemoveReminder(index);
    }
  }

}