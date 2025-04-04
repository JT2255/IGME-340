import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_overlays/overlay_pause.dart';
import 'package:flame_overlays/overlay_settings.dart';
import 'overlay_info.dart';
import 'overlay_main.dart';
import 'overlay_title.dart';
import 'package:flutter/material.dart';

import 'game.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: OverlayTutorial(context)..paused = true,
          overlayBuilderMap: {
            'title': (_, game) {
              return OverlayTitle(game: game);
            },
            'main': (_, game) {
              return MainOverlay(context, game);
            },
            'pause': (_, game) {
              return PauseOverlay(context, game);
            },
            'info': (_, game) {
              return InfoOverlay(game: game as OverlayTutorial);
            },
            'settings': (_, game) {
              return SettingsOverlay(context, game);
            },
          },
          initialActiveOverlays: const ['title'],
        ),
      ),
    );
  }
}
