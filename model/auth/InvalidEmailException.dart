class InvalidEmailException implements Exception
{
  String errorMessage;

  InvalidEmailException({this.errorMessage});
}