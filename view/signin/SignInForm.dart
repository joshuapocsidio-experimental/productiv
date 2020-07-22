import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:productiv/controller/animation/AnimationHandler.dart';
import 'package:productiv/controller/service/FirebaseAuthService.dart';
import 'package:productiv/model/auth/UserManager.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:productiv/view/signin/SignInEmailAndPass.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm>{

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(50),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SignInEmailAndPass(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("OR")),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ]
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: FlatButton(
                        color: Colors.redAccent,
                        onPressed: () async {
                          try
                          {
                            FirebaseAuthService auth = new FirebaseAuthService();
                            await auth.signInWithGoogle();
                          }
                          catch(e)
                          {
                            print(e.message);
                          }
                        },
                        child: Text(
                          "Google",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: FlatButton(
                        color: Colors.blueAccent,
                        onPressed: () async {
                          try
                          {
                            // TODO : Add facebook log in
                          }
                          catch(e)
                          {
                            print(e.message);
                          }
                        },
                        child: Text(
                          "Facebook",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
