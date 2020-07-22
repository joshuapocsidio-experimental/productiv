import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HoverIcon extends StatefulWidget
{
  final AnimatedIconData icon;
  final double size;
  final Color color;

  HoverIcon({this.icon, this.size, this.color});

  @override
  _HoverIconState createState() => _HoverIconState();
}

class _HoverIconState extends State<HoverIcon> with TickerProviderStateMixin {

  bool _hovering = false;
  AnimationController controller;

  void _mouseHovering(bool isHovering)
  {
    setState(() {
      _hovering = isHovering;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (val){
        _mouseHovering(true);
        controller.forward();
      },
      onExit: (val){
        _mouseHovering(false);
        controller.reverse();
      },
      child: AnimatedIcon(
        icon: widget.icon,
        progress: controller,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}
