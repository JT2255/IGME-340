// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
//import "globals.dart";
import 'active.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'package:go_router/go_router.dart';

class AvailableAbilitiesPage extends StatefulWidget {
  const AvailableAbilitiesPage({super.key});

  @override
  State<AvailableAbilitiesPage> createState() => _AvailableAbilitiesPageState();
}

class _AvailableAbilitiesPageState extends State<AvailableAbilitiesPage> {
  @override
  Widget build(BuildContext context) {
    var gameProvider = context.watch<GameProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Abilities'),
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
                Colors.green,
              ]),
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Money: ${gameProvider.money}',
              style: const TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveAbilitiesPage()));
                    //Navigator.pushNamed(context, "/active");
                    context.go("/active");
                  },
                  child: const Icon(Icons.list),
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
                itemCount: gameProvider.abilitiesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xDDFFFFFF),
                    elevation: 4,
                    child: ListTile(
                      // onTap: () {
                      //   //Navigator.pushNamed(context, "/details", arguments: index);
                      //   Navigator.pushNamed(context, "/details", arguments: {
                      //     "name": abilitiesList[index]["name"],
                      //     "cost": abilitiesList[index]["cost"],
                      //   });
                      // },

                      // onTap: () async {
                      //   final returnData = await Navigator.pushNamed(
                      //       context, "/details",
                      //       arguments: {
                      //         "name": abilitiesList[index]["name"],
                      //         "cost": abilitiesList[index]["cost"],
                      //       });

                      //   if (returnData != null) {
                      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Got Back: $returnData")));
                      //   }
                      // },
                      onTap: () {
                        context.go(
                          "/details",
                          extra: gameProvider.abilitiesList[index]
                        );
                      },
                      title: Text(gameProvider.abilitiesList[index]["name"]),
                      subtitle: Text("Cost: \$${gameProvider.abilitiesList[index]['cost']}"),
                      trailing: ElevatedButton(
                        onPressed: (gameProvider.abilitiesList[index]["cost"] >= gameProvider.money) ? null : () {
                          final curItem = gameProvider.abilitiesList[index];
                          final int cost = curItem["cost"];
                          
                          gameProvider.updateMoney(-cost);
                          gameProvider.moveAvailableToActive(curItem);
                          gameProvider.updateClickModifier(curItem);
                        },
                        child: const Text("Buy"),
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
