import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:provider/provider.dart';

class SignInInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: Center(
                child: Text(
                  "Manage your schedule and stay on top of your productivity!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.check,
                color: secondaryColor,
              ),
              title: Text(
                  "Full overview of your whole calendar"
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.check,
                color: secondaryColor,
              ),
              title: Text(
                  "Easily view events and activities you've planned ahead"
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.check,
                color: secondaryColor,
              ),
              title: Text(
                  "Routines and reminders made easy for you"
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.check,
                color: secondaryColor,
              ),
              title: Text(
                  "Ability to attach notes on each event, routine, and reminder"
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.check,
                color: secondaryColor,
              ),
              title: Text(
                  "Easy to use!"
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,),
                  child: FlatButton(
                    color: secondaryColor,
                    onPressed: () {
                      Provider.of<GlobalKey<FlipCardState>>(context, listen: false).currentState.toggleCard();
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,),
                  child: FlatButton(
                    color: secondaryColor,
                    onPressed: () {  },
                    child: Text(
                      "About Us",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
