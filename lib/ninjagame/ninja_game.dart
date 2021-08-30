import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:fgame/ninjagame/enemies/slime.dart';
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
        return BonfireTiledWidget(
          player: DarkNinja(
            Vector2(2 * GameMap.tileSize, 5 * GameMap.tileSize),
          ),
          joystick: Joystick(
            directional: JoystickDirectional(
              isFixed: false,
            ),
            actions: [
              JoystickAction(
                actionId: PlayerAttackType.AttackMelee,
                // sprite: Sprite.load('joystick_atack.png'),
                align: JoystickActionAlign.BOTTOM_RIGHT,
                size: 80,
                margin: EdgeInsets.only(bottom: 50, right: 50),
              ),
            ],
          ),
          map: TiledWorldMap(
            'tiledMaps/map1.json',
            forceTileSize: Size(GameMap.tileSize, GameMap.tileSize),
            objectsBuilder: {
              "slime": (properties) => Slime(properties.position)
            },
          ),
          background: BackgroundColorGame(Colors.blueGrey[900]!),
          // lightingColorGame: Colors.black.withOpacity(0.7),
          cameraConfig: CameraConfig(
            moveOnlyMapArea: true,
          ),
          showFPS: true,
          showCollisionArea: true,
        );
      },
    );
  }
}
