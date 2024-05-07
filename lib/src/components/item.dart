import 'dart:async';
import 'dart:ui';

import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:brick_breaker/src/components/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';

class Item extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Item({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(0xff9208e7)
            ..style = PaintingStyle.fill,
          children: [CircleHitbox()],
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final image = await game.images.load('power-up.png');
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(16),
    );
    animation = spriteSheet.createAnimation(row: 1, stepTime: 0.5);
    size = Vector2.all(32);
  }

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
