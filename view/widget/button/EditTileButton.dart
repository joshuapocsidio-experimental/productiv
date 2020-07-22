import 'package:flutter/material.dart';
import 'package:productiv/view/widget/container/HoverContainer.dart';
import 'package:provider/provider.dart';

class EditTileButton extends StatefulWidget {
  final Function onTap;
  final bool lone;
  final IconData icon;
  final Color iconColor;
  final Color hoverColor;

  EditTileButton({this.lone, this.icon, this.hoverColor, this.iconColor, this.onTap});

  @override
  _EditTileButtonState createState() => _EditTileButtonState();
}

class _EditTileButtonState extends State<EditTileButton> {
  bool hoverStatus;

  void updateHoverStatus(bool status)
  {
    setState(() {
      hoverStatus = status;
    });
  }

  @override
  void initState() {
    super.initState();
    hoverStatus = false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.lone == true || widget.lone == null ?
      HoverContainer(
        hoverColor: Colors.white,
        borderRadius: BorderRadius.circular(100),
        onTap: (){
          if(widget.onTap != null){
            widget.onTap();
          }
        },
        onHover: (value){
          updateHoverStatus(value);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            widget.icon,
            size: 25,
            color: hoverStatus == true ? (widget.iconColor != null ? widget.iconColor : Colors.grey) : null,
          ),
        ),
      ):
      Consumer<bool>(
        builder: (_,status,__){
          return HoverContainer(
            hoverColor: widget.hoverColor != null ? widget.hoverColor : Colors.white,
            borderRadius: BorderRadius.circular(100),
            onTap: (){
              if(widget.onTap != null){
                widget.onTap();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                widget.icon,
                size: 25,
                color: Provider.of<bool>(context) == true ? (widget.iconColor != null ? widget.iconColor : Colors.grey) : null,
              ),
            ),
          );
        },
      );
  }
}
