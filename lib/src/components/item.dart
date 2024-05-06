import 'dart:ui';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/components/components.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class Item extends CircleComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Item({
    required super.position,
  }) : super(
          radius: ballRadius,
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(0xff9208e7)
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        );

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 150 * dt);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bat) {
      removeFromParent();
      game.world.children.query<Ball>().first.penetrable = true;
      FlameAudio.play('item.mp3');
    }
  }
}
