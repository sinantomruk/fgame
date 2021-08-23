import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        "NinjaAdventure/Actor/Characters/DarkNinja/SeparateAnim/Idle.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(31, 0),
        ),
      );

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        "NinjaAdventure/Actor/Characters/DarkNinja/SeparateAnim/Idle.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(47, 0),
        ),
      );

  static Future<SpriteAnimation> get idleUp => SpriteAnimation.load(
        "NinjaAdventure/Actor/Characters/DarkNinja/SeparateAnim/Idle.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(15, 0),
        ),
      );

  static Future<SpriteAnimation> get idleDown => SpriteAnimation.load(
        "NinjaAdventure/Actor/Characters/DarkNinja/SeparateAnim/Idle.png",
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 0),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        "NinjaAdventure/Actor/Characters/DarkNinja/SeparateAnim/Walk.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(47, 0),
          amountPerRow: 1,
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        "NinjaAdventure/Actor/Characters/DarkNinja/SeparateAnim/Walk.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(31, 0),
          amountPerRow: 1,
        ),
      );

  static Future<SpriteAnimation> get runUp => SpriteAnimation.load(
        "NinjaAdventure/Actor/Characters/DarkNinja/SeparateAnim/Walk.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(15, 0),
          amountPerRow: 1,
        ),
      );

  static Future<SpriteAnimation> get runDown => SpriteAnimation.load(
        "NinjaAdventure/Actor/Characters/DarkNinja/SeparateAnim/Walk.png",
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 0),
          amountPerRow: 1,
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleLeft: idleLeft,
        idleRight: idleRight,
        idleDown: idleDown,
        idleUp: idleUp,
        runLeft: runLeft,
        runRight: runRight,
        runDown: runDown,
        runUp: runUp,
      );
}
