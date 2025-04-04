import 'dart:async';
import 'package:flame/components.dart';
import 'main.dart';

class Player extends SpriteComponent with HasGameRef<FlameDemoGame> {
  late Vector2 _newPosition = Vector2.zero();
  final JoystickComponent joystick;

  Player({required this.joystick});

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache("player.png"));
    anchor = Anchor.center;
    height = 100;
    width = 100;
    position = Vector2(
      game.size.x / 2,
      game.size.y - 100,
    );

    _newPosition = position;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Tap version
    // if (position.distanceTo(_newPosition) > 1) {
    //   position = position + (_newPosition - position).normalized() * 100 * dt;
    // }

    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * 300 * dt);
      angle = joystick.delta.screenAngle();
    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void moveTo(Vector2 position) {
    _newPosition = position;
  }
}
