import 'dart:async';
import 'dart:ui';

import 'package:brick_breaker/src/isometric_game/config.dart';
import 'package:brick_breaker/src/isometric_game/isometric_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class TileMap extends IsometricTileMapComponent
    with HasGameReference<IsometricGame> {
  TileMap({
    required Image image,
    super.position,
  }) : super(
          SpriteSheet(
            image: image,
            srcSize: Vector2.all(Config.srcTileSize),
          ),
          Config.mapMatrix,
          destTileSize: Vector2.all(Config.destTileSize),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final image = await game.images.load('tiles.png');
    tileset = SpriteSheet(
      image: image,
      srcSize: Vector2.all(Config.srcTileSize),
    );
  }
}
