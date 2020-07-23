class Reminder
{
  String _documentID;
  bool isDone;
  String title;
  String description;

  Reminder({bool isDone, String title, String description})
  {
    this.isDone = isDone != null ? isDone : false;
    this.title = title;
    this.description = description;
  }

  void assignID({String id})
  {
    _documentID = id;
  }

  String getID()
  {
    return _documentID;
  }

  // Methods
  void toggle()
  {
    isDone = !isDone;
  }
}