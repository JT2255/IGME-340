import 'package:flutter/material.dart';

Widget SettingsOverlay(context, game) {
  return Center(
    child: Container(
      width: 350,
      height: 400,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 151, 101, 213),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Settings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 48,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note),
              ),
              Expanded(
                child: Slider(
                  value: 100,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: "100",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.volume_up),
              ),
              Expanded(
                child: Slider(
                  value: 100,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: "100",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              game.paused = false;
              game.overlays.remove("settings");
            },
            child: const Text("Close"),
          ),
        ],
      ),
    ),
  );
}
