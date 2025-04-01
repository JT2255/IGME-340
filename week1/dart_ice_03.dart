var player01 = {
  'name': 'Leeroy Jenkins',
  'sex': 'M',
  'class': 'Knight',
  'hp': 1000
};

Map player02 = {
  'name': 'Jarod Lee Nandin',
  'sex': 'M',
  'class': 'Overlord',
  'hp': 9000
};

Map<String, dynamic> player03 = {
  'name': 'Samantha Evelyn Cook',
  'sex': 'F',
  'class': 'Gunter',
  'hp': 5000
};

void main() {
  /* print(player01);
  print("${player01.runtimeType}");
  print(player02);
  print("${player02.runtimeType}");
  print(player03);
  print("${player03.runtimeType}"); */

  var player04 = Map();
  player04['name'] = 'Gordon Freeman';
  player04['sex'] = 'M';
  player04['class'] = 'Scientist';
  player04['hp'] = 6000;

  /* print("player04: $player04");
  print("player04: ${player04.runtimeType}"); */
  
  //create player5
  var player05 = {'name': 'Joe', 'sex': 'M', 'class': 'Wizard', 'hp': 5000};

  //add armor to player5 and remove hp
  print(player05);
  player05['armor'] = 5000;
  player05.remove('hp');
  print(player05);

  //create new map with more items
  var moreStuff = {'mp': 1000, 'money': 500, 'xp': 15000, 'level': 5};

  //add keys and values from moreStuff to all players
  player01.addAll(moreStuff);
  player02.addAll(moreStuff);
  player03.addAll(moreStuff);
  player04.addAll(moreStuff);
  player05.addAll(moreStuff);

  //print out keys and values of player5
  print(player05.keys);
  print(player05.values);

  //create a list of all the players and print it
  var playerList = [player01, player02, player03, player04, player05];
  print(playerList);

  //print out name of second player in list
  print(playerList[1]['name']);

  //loop through player list and print each name and class
  for (int i = 0; i < playerList.length; i++) {
    print(playerList[i]['name'] + ": " + playerList[i]['class']);
  }
  
  //clear player1
  player01.clear();
  print(player01);
}