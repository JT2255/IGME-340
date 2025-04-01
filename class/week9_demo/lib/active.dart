// ignore_for_file: unused_import

import 'package:flutter/material.dart';
//import "globals.dart";
import "available.dart";
import 'game_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ActiveAbilitiesPage extends StatefulWidget {
  const ActiveAbilitiesPage({super.key});

  @override
  State<ActiveAbilitiesPage> createState() => _ActiveAbilitiesPageState();
}

class _ActiveAbilitiesPageState extends State<ActiveAbilitiesPage> {
  @override
  Widget build(BuildContext context) {
    var gameProvider = context.watch<GameProvider>();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Abilities'),
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
                Colors.yellow,
              ]),
        ),
        child: Column(
          children: [
            Text(
              'Money: ${gameProvider.money}',
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              "Modifier: ${gameProvider.countModifier}",
              style: const TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => AvailableAbilitiesPage()));
                    //Navigator.pushReplacementNamed(context, "/available");
                    context.go("/available");
                  },
                  child: const Icon(Icons.store),
                ),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    context.go("/");
                  },
                  child: Text("Back"),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: gameProvider.activeAbilitiesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xDDFFFFFF),
                    elevation: 4,
                    child: ListTile(
                      title: Text(gameProvider.activeAbilitiesList[index]["name"]),
                      subtitle:
                          Text("Cost: ${gameProvider.activeAbilitiesList[index]["cost"]}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          final curItem = gameProvider.activeAbilitiesList[index];
                          final int cost = curItem["cost"];
                          
                          gameProvider.moveActiveToAvailable(curItem);
                          gameProvider.updateClickModifier(curItem);
                          gameProvider.updateMoney(cost);
                        },
                        child: const Text("Remove"),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
