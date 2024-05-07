import 'dart:async';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/components/components.dart';
import 'package:brick_breaker/src/components/item.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class Brick extends SpriteComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Brick({required super.position, required Color color})
      : super(
          size: Vector2(brickWidth, brickHeight),
          anchor: Anchor.center,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
          children: [RectangleHitbox()],
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('ufo.png');
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Ball) {
      removeFromParent();
      game.score.value += 100;
      FlameAudio.play('Bluezone_BC0295_sci_fi_weapon_gun_shot_008.wav');

      if (game.rand.nextInt(10) == 0) {
        game.world.add(
          Item(
            position: position,
          ),
        );
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (position.y > game.height * 0.85) {
      game.playState = PlayState.gameOver;
    }

    if (game.playState == PlayState.playing) {
      position += Vector2(0, scrollSpeed * dt);
    }
  }
}
