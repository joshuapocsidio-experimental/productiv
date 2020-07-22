import 'package:flutter/material.dart';

class AnimationHandler {
  AnimationController animationController;
  Animation<double> animation;

  AnimationHandler(AnimationController animationController, Animation<double> animation) {
    animationController = animationController;
    animation = animation;
  }
}