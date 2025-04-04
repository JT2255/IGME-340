import 'package:flutter/material.dart';

Widget PauseOverlay(context, game) {
  return Center(
    child: Container(
      width: 350,
      height: 400,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 168, 216, 198),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Game Paused",
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
              game.overlays.remove("pause");
            },
            child: const Text("Resume"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Settings"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Quit"),
          ),
        ],
      ),
    ),
  );
}
