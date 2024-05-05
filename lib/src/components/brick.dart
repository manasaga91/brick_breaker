import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/components/ball.dart';
import 'package:brick_breaker/src/components/bat.dart';
import 'package:brick_breaker/src/components/item.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Brick extends RectangleComponent
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
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    game.score.value += 100;

    if (game.rand.nextInt(10) == 0) {
      game.world.add(
        Item(
          position: position,
        ),
      );
    }

    if (game.world.children.query<Brick>().length == 1) {
      game.playState = PlayState.won;
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Bat>());
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, scrollSpeed * dt);
  }
}
