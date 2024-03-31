import 'package:flutter/material.dart';

const brickColors = [
  Color(0xfffe4470),
  Color(0xfffe4900),
  Color(0xfff78f2e),
  Color(0xfffedc0c),
  Color(0xffd1f20a),
  Color(0xff5cd05b),
  Color(0xff03c1cd),
  Color(0xff0acdfe),
  Color(0xff0e10e6),
  Color(0xff9208e7),
];

const gameWidth = 820.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth * 0.02;
const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.05;
const brickGutter = gameWidth * 0.015;
final brickWidth =
    (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length;
const brickHeight = gameHeight * 0.03;
const difficultyModifier = 1.03;
