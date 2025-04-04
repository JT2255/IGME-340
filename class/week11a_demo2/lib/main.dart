import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Game Demo"),
        backgroundColor: Colors.blue,
      ),
      body: GameWidget(
        game: FlameDemoGame(),
      ),
    ));
  }
}

// Game is all!
// void main() {
//   runApp(
//     GameWidget(
//       game: FlameDemoGame(),
//     ),
//   );
// }

// class FlameDemoGame extends FlameGame with PanDetector {
// class FlameDemoGame extends FlameGame with TapCallbacks {
class FlameDemoGame extends FlameGame {
  late Player player;
  late JoystickComponent joystick;
  final knobPaint = BasicPalette.red.withAlpha(200).paint();
  final knobBgPaint = BasicPalette.red.withAlpha(100).paint();

  @override
  Future<void> onLoad() async {
    await images.loadAll(["player.png"]);

    // Joystick
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: knobBgPaint),
      margin: EdgeInsets.only(left: 20, bottom: 20),
    );

    player = Player(joystick: joystick);
    add(player);
    add(joystick);
  }

  // @override
  // void onTapUp(TapUpEvent event) {
  //   // player.position = event.localPosition;
  //   player.moveTo(event.localPosition);
  // }

  // @override
  // void onPanUpdate(DragUpdateInfo info) {
  //   player.move(info.delta.global);
  // }
}
