import 'package:bonfire/bonfire.dart';

class GameMap {
  static double tileSize = 45;

  static Vector2 getRelativeTilePosition(int x, int y) {
    return Vector2(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }
}
