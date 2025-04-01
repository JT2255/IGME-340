/// our list of monsters
List<dynamic> monsters = [];

///
/// Our Base Monster class
///
class Monster {
  String name;
  int hp;
  int speed;
  int score;
  String type;

  /// constructor
  Monster({this.name = "", this.hp = 0, this.speed = 0, this.score = 0, this.type = "Enemy"});

  /// class method
  void status() {
    print("name: $name, hp: $hp, speed: $speed, score: $score, type: $type");
  }
}

class Goomba extends Monster {
  String color;
  int dmg;

  Goomba({super.name, super.hp, super.speed, super.score, super.type, this.color = "brown", this.dmg = 20});

  @override
  void status() {
    print("Name: $name, HP: $hp, Speed: $speed, Score: $score, Color: $color, Dmg: $dmg, Type: $type");
  }
}

class Boo extends Monster {
  int mp;

  Boo({super.name, super.hp, super.speed, super.score, super.type, this.mp = 100});

  void castSpell() {
    mp -= 10;
    print("Spell casted");
  }

  @override
  void status() {
    print("Name: $name, HP: $hp, Speed: $speed, Score: $score, MP: $mp, Type: $type");
  }
}

//create set number of monsters and add to monsters list
void makeSomeMonsters (int num) {
  for (int i = 0; i < num; i++) {
    monsters.add(Goomba(name: "Goomba ${i+1}", type: "Goomba"));
    monsters.add(Boo(name: "Boo ${i+1}", type: "Boo"));
  }
}

//print out all monsters of specific type in monsters list
void showMonsters (String monType) {
  for (int i = 0; i < monsters.length; i++) {
    if (monsters[i].type == monType) {
      monsters[i].status();
    }
  }
}

void main() {
  makeSomeMonsters(3);
  showMonsters("Boo");
  showMonsters("Goomba");
}