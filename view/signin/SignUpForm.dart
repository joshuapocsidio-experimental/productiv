import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:productiv/model/auth/UserManager.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FlipCardState> flipCardKey;

  SignUpForm({this.flipCardKey});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  String name;
  int age;
  String email;
  String password;

  @override
  void initState() {
    super.initState();

    name = "";
    age = 0;
    email = "";
    password = "";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                onChanged: (newName){
                  setState(() {
                    name = newName;
                    print("Name : $name");
                  });
                },
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Age",
                ),
                onChanged: (newAge){
                  setState(() {
                    age = int.parse(newAge);
                    print("Age : $age");
                  });
                },
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                onChanged: (newEmail){
                  setState(() {
                    email = newEmail;
                    print("Email : $email");
                  });
                },
              ),
            ),
            Container(
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                onChanged: (newPass){
                  setState(() {
                    password = newPass;
                    print("Password : $password");
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: FlatButton(
                    color: secondaryColor,
                    onPressed: () async {

                      print("NAME : $email");
                      UserManager userManager = Provider.of<UserManager>(context, listen: false);

                      try{
                        await userManager.signUpWithEmailAndPass(email, password, name, age);
                        print("Register");
                      }
                      catch(signUpException)
                      {
                        print("ERROR : ${signUpException.toString()}");
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: FlatButton(
                    color: secondaryColor,
                    onPressed: () {
                      Provider.of<GlobalKey<FlipCardState>>(context, listen: false).currentState.toggleCard();
                    },
                    child: Text(
                      "Return",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
