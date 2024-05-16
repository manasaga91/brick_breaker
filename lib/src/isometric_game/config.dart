abstract class Config {
  static const double gameWidth = 1200;
  static const double gameHeight = 800;

  static const double scale = 2;

  static const double srcTileSize = 32;
  static const double destTileSize = srcTileSize * Config.scale;

  static const double srcCharacterWidth = 16;
  static const double srcCharacterHeight = 24;
  static const double characterStepTime = 0.2;

  static const List<List<int>> mapMatrix = [
    [3, 1, 1, 1, 0, 0],
    [-1, 1, 2, 1, 0, 0],
    [-1, 0, 1, 1, 0, 0],
    [-1, 1, 1, 1, 0, 0],
    [1, 1, 1, 1, 0, 2],
    [1, 3, 3, 3, 0, 2],
  ];
}
