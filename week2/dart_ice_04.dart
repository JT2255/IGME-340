void main() {
  /*
  helloFunction("hi", 10);
  helloFunction(null,10);
  helloFunction3();
  printThree(first: "Hello", second: "Fall", third: "Season");
  printThree(second:"Hello"); */
  
  addThree(num1: 10, num2: 20,num3: 30);
  print(joinStrings(string2: "hi"));
  print(hiLow(5.5, 6.6, 7.7));
  print(makeCharacter(name: "Joe", playerClass: "Mage"));
}

//print input string and int
void helloFunction (String? a, int b) {
  print ("$a, $b");
}

//print input string and int
void helloFunction3 ([String a="hi", int b=10]) {
  print ("$a, $b");
}

//print input strings
void printThree({String? first, required String second, String? third}) {
  print("$first, $second, $third");
}

//add 3 input numbers together
void addThree({int num1=1, int num2=1, int num3=1}) {
  print(num1 + num2 + num3);
}

//add up to 5 strings together
String joinStrings({String? string1, String? string2, String string3="third", String string4="fourth"}) {
  if (string1 != null && string2 != null) {
    return string1 + string2 + string3 + string4;
  }
  else if (string1 != null && string2 == null) {
    return string1 + string3 + string4;
  }
  else if (string1 == null && string2 != null) {
    return string2 + string3 + string4;
  }

  return string3 + string4;
}

//adds 3 floats and then rounds up and down
Map hiLow(double x, double y, double z) {
  double sum = x + y + z;
  int high = sum.round();
  int low = sum.truncate();
  
  var hiLowMap = {
    'sum': sum,
    'high': high,
    'low': low
  };
  
  return hiLowMap;
}

//makes a character map
Map makeCharacter({String? name, String? playerClass, int mp=100, int hp=100}) {
  var char = {
    'Name': name,
    'Class': playerClass,
    'MP': mp,
    'HP': hp,
    'XP': 0,
    'Level': 1
  };
  
  return char;
}