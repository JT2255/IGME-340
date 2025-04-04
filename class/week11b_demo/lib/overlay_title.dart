import 'package:flutter/material.dart';

class OverlayTitle extends StatelessWidget {
  final game;
  const OverlayTitle({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 400,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 236, 203),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Overlay Tutorial",
              style: TextStyle(
                color: Colors.black,
                fontSize: 48,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                game.paused = false;
                game.overlays.remove('title');
                game.overlays.add('main');
              },
              child: const Text("Start Game"),
            ),
            ElevatedButton(
              onPressed: () {
                game.overlays.add("settings");
              },
              child: const Text("Settings"),
            ),
          ],
        ),
      ),
    );
  }
}
