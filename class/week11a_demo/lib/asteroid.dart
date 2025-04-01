import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';

///
/// Asteroid Sprite
/// This is our asteroid sprite that will bounce off the walls
/// When invoked it will create an instance of an Asteroid spritecomponent.
/// The size, position, and velocity are randomized.
/// The update method ensures the asteroid stays on screen and bounces off the walls.
///

class Asteroid extends SpriteComponent with HasGameRef {
  late Vector2 velocity;

  //
  // onLoad
  // sets up an asteroid with a random position, size, and velocity
  //
  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('asteroid.png'));
    anchor = Anchor.center;
    position = Vector2(Random().nextDouble() * gameRef.size.x,
        Random().nextDouble() * gameRef.size.y);
    double rndSize = Random().nextInt(100).toDouble() + 25;
    size = Vector2(rndSize, rndSize);
    velocity =
        Vector2(Random().nextDouble() * 200, Random().nextDouble() * 200);
  }

  //
  // update
  // moves the asteroid and bounces it off the walls
  //
  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    if (position.y < 0 || position.y > gameRef.size.y) {
      velocity = Vector2(velocity.x, -velocity.y);
    }
    if (position.x < 0 || position.x > gameRef.size.x) {
      velocity = Vector2(-velocity.x, velocity.y);
    }
  }
}
