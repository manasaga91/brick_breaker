import 'dart:async';
import 'dart:ui';

import 'package:brick_breaker/src/isometric_game/config.dart';
import 'package:brick_breaker/src/isometric_game/isometric_game.dart';
import 'package:flame/components.dart';

class TileSelector extends SpriteComponent
    with HasGameReference<IsometricGame> {
  TileSelector()
      : super(
          size: Vector2.all(Config.destTileSize),
        );

  bool show = true;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final image = await game.images.load('selector.png');
    sprite = Sprite(
      image,
      srcSize: Vector2.all(Config.srcTileSize),
    );
  }

  @override
  void render(Canvas canvas) {
    if (show) {
      super.render(canvas);
    }
  }
}
