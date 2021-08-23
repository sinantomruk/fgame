import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:fgame/ninjagame/map.dart';
import 'package:fgame/ninjagame/player/player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class NinjaGame extends StatelessWidget {
  const NinjaGame({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        GameMap.tileSize = max(constraints.maxHeight, constraints.maxWidth) /
            (kIsWeb ? 25 : 22);
        debugPrint(GameMap.tileSize.toString());
        return BonfireTiledWidget(
          player: DarkNinja(
            Vector2(2 * GameMap.tileSize, 5 * GameMap.tileSize),
          ),
          joystick: Joystick(
            directional: JoystickDirectional(),
          ),
          map: TiledWorldMap(
            'tiledMaps/map1.json',
            forceTileSize: Size(GameMap.tileSize, GameMap.tileSize),
            objectsBuilder: {
              // 'light': (properties) => Torch(properties.position),
            },
          ),
          background: BackgroundColorGame(Colors.blueGrey[900]!),
          // lightingColorGame: Colors.black.withOpacity(0.7),
        );
      },
    );
  }
}
