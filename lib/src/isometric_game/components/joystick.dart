import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Joystick extends JoystickComponent {
  Joystick()
      : super(
          knob: CircleComponent(
            radius: 30,
            paint: BasicPalette.blue.withAlpha(200).paint(),
          ),
          background: CircleComponent(
            radius: 100,
            paint: BasicPalette.blue.withAlpha(100).paint(),
          ),
          margin: const EdgeInsets.only(
            left: 40,
            bottom: 40,
          ),
        );
}