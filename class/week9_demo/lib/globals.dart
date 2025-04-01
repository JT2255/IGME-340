import 'dart:async';

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
