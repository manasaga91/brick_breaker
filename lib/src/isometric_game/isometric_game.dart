import 'package:brick_breaker/src/isometric_game/components/character.dart';
import 'package:brick_breaker/src/isometric_game/components/joystick.dart';
import 'package:brick_breaker/src/isometric_game/components/tile_map.dart';
import 'package:brick_breaker/src/isometric_game/components/tile_selector.dart';
import 'package:brick_breaker/src/isometric_game/config.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class IsometricGame extends FlameGame {
  IsometricGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: Config.gameWidth,
            height: Config.gameHeight,
          ),
        );

  final topLeftPosition = Vector2(Config.gameWidth / 2, Config.gameHeight / 2);
  final joystick = Joystick();
  final tileSelector = TileSelector();

  late IsometricTileMapComponent tileMap;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.viewport.add(joystick);
    add(tileSelector);

    final tilesetImage = await images.load('tiles.png');
    add(
      tileMap = TileMap(
        image: tilesetImage,
        position: topLeftPosition,
      ),
    );

    add(
      Character(
        position: topLeftPosition,
        joystick: joystick,
      ),
    );
  }

  void selectBlock(Vector2 p) {
    final block = tileMap.getBlock(p);
    tileSelector.show = tileMap.containsBlock(block);
    tileSelector.position
        .setFrom(topLeftPosition + tileMap.getBlockRenderPosition(block));
  }
}
