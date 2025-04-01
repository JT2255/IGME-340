// ignore_for_file: unused_local_variable, unused_import

import 'package:flutter/material.dart';
import 'globals.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatelessWidget {

  final Map data;

  const DetailsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    String abilityName = data["name"];
    int abilityCost = data["cost"];
    // final int index = ModalRoute.of(context)?.settings.arguments as int;
    // String abilityName = abilitiesList[index]["name"];
    // int abilityCost = abilitiesList[index]["cost"];

    //final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    //String abilityName = args["name"];
    //int abilityCost = args["cost"];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ability Details'),
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
                Color.fromARGB(255, 255, 138, 138),
              ]),
        ),
        child: Column(children: [
          Text(
            "Ability: $abilityName",
            style: const TextStyle(fontSize: 30),
          ),
          Text(
            "Cost: \$$abilityCost",
            style: const TextStyle(fontSize: 30),
          ),
          ElevatedButton(
            onPressed: () {
              //Navigator.pop(context, "Return from $abilityName details");
              context.go("/");
            },
            child: const Text('Go Back with Stuff'),
          ),
        ]),
      ),
    );
  }
}
