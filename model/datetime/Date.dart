enum Month{
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December
}


class Date
{
  Map<int, Month> _monthMap;

  final int _month;
  final int _day;

  String _monthName;
  String _dayName;

  Date(this._month, this._day)
  {
    _monthMap = new Map();
    _initializeMonthMap();


  }


  void _initializeMonthMap()
  {
    _monthMap[1] = Month.January;
    _monthMap[2] = Month.February;
    _monthMap[3] = Month.March;
    _monthMap[4] = Month.April;
    _monthMap[5] = Month.May;
    _monthMap[6] = Month.June;
    _monthMap[7] = Month.July;
    _monthMap[8] = Month.August;
    _monthMap[9] = Month.September;
    _monthMap[10] = Month.October;
    _monthMap[11] = Month.November;
    _monthMap[12] = Month.December;

  }
}