import 'dart:ui';

import 'package:flutter/material.dart';

class HoverContainer extends StatefulWidget
{
  final Widget child;
  final Function onTap;
  final Function onHover;
  final Color hoverColor;
  final BorderRadius borderRadius;

  HoverContainer({this.child, this.onTap, this.onHover, this.hoverColor, this.borderRadius});

  @override
  _HoverContainerState createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap != null ? widget.onTap : () {},
        hoverColor: widget.hoverColor != null ? widget.hoverColor : null,
        onHover: widget.onHover != null ? widget.onHover : (value){},
        borderRadius: widget.borderRadius != null ? widget.borderRadius : BorderRadius.zero,
        child: widget.child,
      ),
    );
  }
}
