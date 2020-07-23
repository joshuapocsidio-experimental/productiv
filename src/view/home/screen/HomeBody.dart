import 'package:flutter/material.dart';
import 'package:productiv/src/model/auth/UserManager.dart';
import 'package:productiv/src/model/colors/ColorPalette.dart';
import 'package:productiv/src/view/home/page/reminder/ReminderPage.dart';
import 'package:provider/provider.dart';

import 'HomeDrawer.dart';

class HomeBody extends StatefulWidget {

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  Widget currentPage;
  void updatePage(Widget selectedPage)
  {
    setState(() {
      currentPage = selectedPage;
    });
  }

  @override
  void initState() {
    super.initState();
    currentPage = new ReminderPage();
  }

  @override
  Widget build(BuildContext context) {
    return         Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: secondaryColor),
        actions: [
          IconButton(
            icon: Icon(
                Icons.label
            ),
            onPressed: (){
              setState(() {

              });
            },
          )
        ],
        title: IntrinsicHeight(
          child: Row(
            children: [
              Text(
                "Productiv",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 30,
                ),
              ),
              VerticalDivider(
                color: primaryColor,
                thickness: 1,
                width: 50,
              ),
              Text("Welcome ${Provider.of<UserManager>(context).currentUser.name}!", style: TextStyle(color: primaryColor, fontSize: 20))
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: currentPage,
      drawer: HomeDrawer(updatePage: updatePage),
    );
  }
}