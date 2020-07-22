import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productiv/model/auth/UserManager.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:productiv/view/home/page/reminder/ReminderPage.dart';
import 'package:productiv/view/home/page/routine/RoutinePage.dart';
import 'package:productiv/view/widget/drawer/DrawerCard.dart';
import 'package:productiv/view/widget/icon/HoverIcon.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {

  final Function updatePage;

  HomeDrawer({this.updatePage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: HoverIcon(
                icon: AnimatedIcons.view_list,
                size: 150,
                color: primaryColor
              ),
            ),
          ),
          Center(
              child: Divider(
                color: secondaryColor,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              )
          ),
          DrawerCard(
            icon: Icons.calendar_today,
            title: "Schedule",
            subtitle: "Keep track of your activities",
            onTap: (){
              //TODO : Add Functionality
              Navigator.pop(context);
            },
          ),
          DrawerCard(
            icon: Icons.event,
            title: "Events",
            subtitle: "Check upcoming events",
            onTap: (){
              //TODO : Add Functionality
              Navigator.pop(context);
            },
          ),
          DrawerCard(
            icon: Icons.event_busy,
            title: "Routines",
            subtitle: "Manage regular routines",
            onTap: (){
              updatePage(RoutinePage());
              Navigator.pop(context);
            },
          ),
          DrawerCard(
            icon: Icons.event_available,
            title: "Reminders",
            subtitle: "Track your reminders",
            onTap: (){
              updatePage(ReminderPage());
              Navigator.pop(context);
            },
          ),
          DrawerCard(
            icon: Icons.event_note,
            title: "Notes",
            subtitle: "Manage personalized notes",
            onTap: (){
              //TODO : Add Functionality
              Navigator.pop(context);
            },
          ),
          Center(
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              )
          ),
          DrawerCard(
            icon: Icons.account_circle,
            title: "Account",
            subtitle: "Manage your account details and preferences",
            onTap: (){
              //TODO : Add Functionality
              Navigator.pop(context);
            },
          ),
          DrawerCard(
            icon: Icons.exit_to_app,
            title: "Sign Out",
            subtitle: "Manage your account details and preferences",
            onTap: () async {
              //TODO : Add Functionality
              Navigator.pop(context);
              UserManager userManager = Provider.of<UserManager>(context, listen: false);

              userManager.updateLoadingStatus(true);
              try{
                await Provider.of<UserManager>(context, listen: false).signOutUser();
              }
              catch(e){
                print("Error: Cannot sign out");
                print(e.message);
              }
              userManager.updateLoadingStatus(false);
            },
          ),
        ]
      ),
    );
  }
}