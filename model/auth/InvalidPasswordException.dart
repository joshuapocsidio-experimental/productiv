class InvalidPasswordException implements Exception
{
  String errorMessage;

  InvalidPasswordException({this.errorMessage});
}