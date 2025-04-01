import 'dart:async';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  int money = 0;
  int countModifier = 1;
  late Timer gameTimer;

  List<Map> abilitiesList = [
    {
      "name": "Click +1",
      "cost": 5,
      "effect": "+",
      "value": 1,
    },
    {
      "name": "Click +5",
      "cost": 10,
      "effect": "+",
      "value": 5,
    },
    {
      "name": "Click +10",
      "cost": 50,
      "effect": "+",
      "value": 10,
    },
    {
      "name": "Money x2",
      "cost": 20,
      "effect": "*",
      "value": 2,
    },
    {
      "name": "Money x3",
      "cost": 100,
      "effect": "*",
      "value": 3,
    },
    {
      "name": "Money x10",
      "cost": 1000,
      "effect": "*",
      "value": 10,
    },
  ];

  List<Map> activeAbilitiesList = [];

  void updateMoney(int amount) {
    money += amount;
    notifyListeners();
  }

  void updateClickModifier(Map curItem) {
    switch (curItem["effect"]) {
      case "+":
        countModifier += curItem["value"] as int;
        break;
      case "*":
        money *= curItem["value"] as int;
        break;
    }

    notifyListeners();
  }

  void moveAvailableToActive(Map curItem) {
    activeAbilitiesList.add(curItem);
    abilitiesList.remove(curItem);
    notifyListeners();
  }

  void moveActiveToAvailable(Map curItem) {
    activeAbilitiesList.remove(curItem);
    abilitiesList.add(curItem);
    notifyListeners();
  }
}
