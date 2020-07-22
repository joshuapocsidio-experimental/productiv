import 'package:flutter/material.dart';

class TransparentFilter extends StatelessWidget
{
  final Color beginColor;
  final Color endColor;

  TransparentFilter({this.beginColor, this.endColor});

  @override
  Widget build(BuildContext context) {

    List<Color> colorBlend = [
      beginColor != null ? beginColor : Colors.white,
      Colors.transparent,
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: colorBlend,
        ),
      ),
    );
  }
}
