//list of monsters
List<dynamic> monsters = [];

class Monster {
  String name;
  int hp;
  int speed;
  int score;

  //constructor
  Monster({this.name = "", this.hp = 0, this.speed = 0, this.score = 0});

  //class method
  void status() {
    print("Name: $name, HP: $hp, Speed: $speed, Score: $score");
  }
}

class Player {
  String name;
  int lives;
  int score;
  int xp;
  int speed;

  Player({this.name = "", this.lives = 3, this.score = 0, this.xp = 0, this.speed = 100});

  void status() {
    print("Name: $name, Lives: $lives, Score: $score, XP: $xp, Speed: $speed");
  }

  void levelUp() {
    xp += 100;
    speed += 10;
    score += 500;
    status();
  }
}

class Treasure {
  String name;
  int value;
  String rarity;
  String type;

  Treasure(this.name, this.value, this.rarity, this.type);

  void status() {
    print("Name: $name, Value: $value, Rarity: $rarity, Type: $type");
  }
}


void main() {
  //Monster myGoomba = Monster(name: "John", hp: 50, speed: 20, score: 200);
  //myGoomba.status();

  Player mario = Player(name: "Mario");
  mario.status();

  for (int i = 0; i < 10; i++) {
    mario.levelUp();
  }

  //add treasures to list
  List<Treasure> treasures = [];
  treasures.add(Treasure("Ankh", 1000, "Rare", "Artifact"));
  treasures.add(Treasure("Diamond", 500, "Rare", "Gem"));
  treasures.add(Treasure("Ruby", 300, "Rare", "Gem"));
  treasures.add(Treasure("Sapphire", 300, "Rare", "Gem"));
  treasures.add(Treasure("Emerald", 300, "Rare", "Gem"));

  //print out all treasures
  for (int i = 0; i < treasures.length; i++){
    treasures[i].status();
  } 

  //cascade new player
  Player luigi = Player();
    luigi
      ..name = "Luigi"
      ..lives = 5
      ..status();
  
  treasures
    ..add(Treasure("Supercomputer", 5000, "Ultra-Rare", "Technology"));
}