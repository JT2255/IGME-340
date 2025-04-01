// ignore_for_file: unused_import

import "dart:async";
import "dart:math";
import 'package:flutter/material.dart';
//import "globals.dart";
import "active.dart";
import "available.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    int countModifier = context.read<GameProvider>().countModifier;
    var gameProvider = context.watch<GameProvider>();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Stupid Clicker Game'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xff555555),
              ]),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // setState(() {
                //   money += countModifier;
                // });
                gameProvider.updateMoney(countModifier);
              },
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const NetworkImage(
                        "https://people.rit.edu/dxcigm/340/assets/images/coins.png"),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      print(exception);
                    },
                  ),
                ),
              ),
            ),
            Text(
              'Money: ${context.watch<GameProvider>().money}',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'Modifier: ${context.watch<GameProvider>().countModifier}',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ActiveAbilitiesPage(),
                    //   ),
                    // );

                    //Navigator.pushNamed(context, "/active");

                    context.go("/active");
                  },
                  child: const Icon(Icons.list),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return AvailableAbilitiesPage();
                    //     },
                    //   ),
                    // );

                    //Navigator.pushNamed(context, "/available");

                    context.go("/available");
                  },
                  child: const Icon(Icons.store),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
