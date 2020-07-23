import 'package:flutter/material.dart';
import 'package:productiv/src/view/widget/cosmetic/filter/TransparentFilter.dart';

class TransparentImage extends StatelessWidget
{
  final AssetImage image;
  final Color color;

  TransparentImage({this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        TransparentFilter(
          beginColor: color,
        ),
      ],
    );
  }
}
