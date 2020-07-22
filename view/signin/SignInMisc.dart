import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:productiv/controller/animation/AnimationHandler.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:productiv/view/signin/SignInInfo.dart';
import 'package:productiv/view/signin/SignUpForm.dart';
import 'package:provider/provider.dart';

class SignInMisc extends StatefulWidget {
  @override
  _SignInMiscState createState() => _SignInMiscState();
}

class _SignInMiscState extends State<SignInMisc> with TickerProviderStateMixin{
  GlobalKey<FlipCardState> cardKey = new GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Productiv",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Provider(
                    create: (context) => cardKey,
                    child: FlipCard(
                      flipOnTouch: false,
                      key: cardKey,
                      back: SignUpForm(),
                      front: SignInInfo(),
                    ),
                  )
              ),
            )
          ],
        ),
      );
  }
}
