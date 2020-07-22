
import 'package:flutter/material.dart';
import 'package:productiv/model/colors/ColorPalette.dart';
import 'package:productiv/view/widget/container/HoverContainer.dart';

class DrawerCard extends StatelessWidget
{
  final IconData icon;
  final String title;
  final String subtitle;
  final Function onTap;

  DrawerCard({this.icon, this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, bottom: 2),
      child: HoverContainer(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: ListTile(
              leading: Icon(
                icon,
                color: secondaryColor,
                size: 24
              ),
              title: Text(title),
              subtitle: Text(subtitle),
              dense: true,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
