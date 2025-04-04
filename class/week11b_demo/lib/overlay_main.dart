import 'package:flutter/material.dart';

Widget MainOverlay(context, game) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      color: Color.fromARGB(48, 245, 154, 50),
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Score: 00",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              game.paused = true;
              game.overlays.add("pause");
            },
            icon: Icon(Icons.pause),
          ),
          IconButton(
            onPressed: () {
              game.paused = true;
              game.overlays.add("settings");
            },
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              game.paused = true;
              game.overlays.add('info');
            },
            icon: Icon(Icons.info),
          ),
        ],
      ),
    ),
  );
}
