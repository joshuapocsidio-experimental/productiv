import 'package:productiv/model/productivity/routine/Routine.dart';
import 'package:productiv/model/productivity/routine/RoutineList.dart';

/// Layer to handle interaction between RoutineList<Routine> model and GUI
class RoutineController
{
  RoutineList _routines;

  RoutineController(RoutineList routines)
  {
    _routines = routines;
  }

  void addRoutine(Routine routine)
  {
    _routines.addRoutine(routine);
  }

  void removeRoutineAt(int index)
  {
    _routines.removeRoutineAt(index);
  }

}