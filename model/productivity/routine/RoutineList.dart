import 'Routine.dart';
import 'RoutineListObserver.dart';

class RoutineList
{
  List<Routine> _routines;
  List<RoutineListObserver> _observers;

  RoutineList()
  {
    _routines = new List();
    _observers = new List();
  }

  // Getters
  List<Routine> getRoutines()
  {
    return List.unmodifiable(_routines);
  }

  Routine getRoutineAt(int index)
  {
    return _routines.elementAt(index);
  }

  int getListSize()
  {
    return _routines.length;
  }

  // Mutators
  void addRoutine(Routine routine)
  {
    _routines.add(routine);
    notifyAddObservers();
  }

  void addRoutines(List<Routine> routines)
  {
    _routines.addAll(routines);
    notifyAddObservers();
  }

  void removeRoutineAt(int index)
  {
    _routines.removeAt(index);
    notifyRemoveObservers(index);
  }

  // Initialize observers
  void addObserver(RoutineListObserver ob)
  {
    _observers.add(ob);
  }

  void notifyAddObservers()
  {
    for(int i = 0; i < _observers.length; i++)
    {
      _observers.elementAt(i).handleAddedRoutine();
    }
  }

  void notifyRemoveObservers(int index)
  {
    for(int i = 0; i < _observers.length; i++)
    {
      _observers.elementAt(i).handleRemoveRoutine(index);
    }
  }

}