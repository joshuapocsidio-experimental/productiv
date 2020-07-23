import 'AnimationHandler.dart';

class AnimationHandlerList
{
  List<AnimationHandler> _animationHandlers;

  AnimationHandlerList()
  {
    _animationHandlers = new List();
  }

  // Mutators
  void addHandler(AnimationHandler animationHandler)
  {
    _animationHandlers.add(animationHandler);
  }

  void removeHandlerAt(int index)
  {
    _animationHandlers.removeAt(index);
  }

  int getListSize()
  {
    return _animationHandlers.length;
  }

  // Accessors
  AnimationHandler getAnimationHandlerAt(int index)
  {
    return _animationHandlers.elementAt(index);
  }
}