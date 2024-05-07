import 'dart:async';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayArea extends SpriteComponent with HasGameReference<BrickBreaker> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xff323333),
          children: [RectangleHitbox()],
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('bg.png');
    size = Vector2(game.width, game.height);
  }
}
