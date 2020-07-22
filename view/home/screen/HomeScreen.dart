import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:productiv/model/auth/UserManager.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:productiv/model/user/User.dart';
import 'package:productiv/view/signin/SignInPage.dart';
import 'package:productiv/view/home/page/reminder/ReminderPage.dart';
import 'package:productiv/view/home/screen/HomeDrawer.dart';
import 'package:provider/provider.dart';

import 'HomeBody.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User user;

  @override
  void initState() {
    super.initState();

    user = Provider.of<UserManager>(context, listen: false).currentUser;
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Provider.of<UserManager>(context).isSignedIn == false ? SignInPage() : HomeBody(),
        Visibility(
          visible: Provider.of<UserManager>(context).isLoading,
          child: Opacity(
            opacity: 0.3,
            child: Container(
              color: Colors.grey,
            ),
          ),
        ),
        Visibility(
          visible: Provider.of<UserManager>(context).isLoading,
          child: Center(
            child: Card(
              color: Colors.white.withOpacity(0.9),
              child: IntrinsicHeight(
                child: IntrinsicWidth(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitFadingCircle(
                          size: 100,
                          color: secondaryColor,
                        ),
                        Text(
                          "Loading...",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
