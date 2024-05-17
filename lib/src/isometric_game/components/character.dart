import 'dart:async';

import 'package:brick_breaker/src/isometric_game/config.dart';
import 'package:brick_breaker/src/isometric_game/isometric_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:gamepads/gamepads.dart';

extension JoystickDirectionValue on JoystickDirection {
  int get value => switch (this) {
        JoystickDirection.up => 0,
        JoystickDirection.upRight => 1,
        JoystickDirection.right => 2,
        JoystickDirection.downRight => 3,
        JoystickDirection.down => 4,
        JoystickDirection.downLeft => 5,
        JoystickDirection.left => 6,
        JoystickDirection.upLeft => 7,
        JoystickDirection.idle => 8,
      };
}

class Character extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<IsometricGame> {
  Character({
    required this.joystick,
    required super.position,
  }) : super(
          anchor: Anchor.bottomCenter,
        );

  final JoystickComponent joystick;

  late final SpriteSheet spriteSheet;
  late final Map<JoystickDirection, SpriteAnimation> animations;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final image = await game.images.load('character.png');
    spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(
        Config.srcCharacterWidth,
        Config.srcCharacterHeight,
      ),
    );

    size = spriteSheet.srcSize * Config.scale;

    animations = Map.fromIterables(
      JoystickDirection.values,
      JoystickDirection.values.map(
        (e) => spriteSheet.createAnimation(
          row: e.value,
          stepTime: Config.characterStepTime,
        ),
      ),
    );

    animation = animations[JoystickDirection.down];

    Gamepads.events.listen((event) {
      print(event.key);
      print(event.type);
      print(event.value);
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (joystick.delta.isZero() || activeCollisions.isNotEmpty) {
      return;
    }

    animation = animations[joystick.direction];
    position.add(joystick.relativeDelta * 50 * dt);
    game.selectBlock(position);
  }
}
