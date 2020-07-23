import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productiv/src/model/colors/ColorPalette.dart';

import 'SignInForm.dart';
import 'SignInMisc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: SizedBox(
            width: 1500,
            height: 800,
            child: Card(
              color: secondaryColor,
              elevation: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SignInForm(),
                  ),
                  Flexible(
                    child: SignInMisc(),
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
