import 'package:bonfire/bonfire.dart';

class WeaponsSpriteSheet {
  static Future<SpriteAnimation> get lanceAnimation => SpriteAnimation.load(
        "NinjaAdventure/Items/Weapons/Lance/SpriteInHand.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.6,
          textureSize: Vector2(6, 16),
        ),
      );

  static Future<Sprite> get lanceSprite =>
      Sprite.load('NinjaAdventure/Items/Weapons/Lance/Sprite.png');
}
