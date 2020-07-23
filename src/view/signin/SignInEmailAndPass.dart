import 'package:flutter/material.dart';
import 'package:productiv/src/model/auth/UserManager.dart';
import 'package:productiv/src/model/colors/ColorPalette.dart';
import 'package:provider/provider.dart';

class SignInEmailAndPass extends StatefulWidget {
  @override
  _SignInEmailAndPassState createState() => _SignInEmailAndPassState();
}

class _SignInEmailAndPassState extends State<SignInEmailAndPass> {

  String email;
  String password;

  Future<void> attemptSignIn() async
  {
    // Get User Manager
    UserManager userManager = Provider.of<UserManager>(context, listen: false);

    userManager.updateLoadingStatus(true);
    try
    {
      await userManager.signInWithEmailAndPass(email, password);
    }
    catch(e)
    {
      print(e.message);
    }
    userManager.updateLoadingStatus(false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Username or Email",
            ),
            onChanged: (newEmail){
              setState(() {
                email = newEmail;
                print(email);
              });
            },
            onSubmitted: (_) async {
              await attemptSignIn();
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
                print(password);
              });
            },
            onSubmitted: (_) async{
              await attemptSignIn();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: FlatButton(
                color: secondaryColor,
                onPressed: () async {
                  // Testing
                  print("EMAIL : $email");
                  print("PASS  : $password");

                  await attemptSignIn();
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        Container(
          child: Text(
            "Forgot Password?",
            style: TextStyle(
                color: secondaryColor,
                fontSize: 12
            ),
          ),
        ),
      ],
    );
  }
}
