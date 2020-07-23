class User
{
  final String uid;
  final String email;

  String name;
  int age;

  User({this.uid, this.name, this.age, this.email});

  @override
  String toString() {
    return "- - - - - - - - - - - - - - - - - - - - - - - -\n"
        "User : \n"
        "    uid   - $uid\n"
        "    email - $email\n"
        "    name  - $name\n"
        "    age   - $age\n"
        "- - - - - - - - - - - - - - - - - - - - - - - -\n";
  }
}