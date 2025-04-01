void main() {
  int myNumber = 1234;
  double myFloat = 1234.6234;
  String myString = "Hello World";
  bool myBoolean = false;
  const myConst = "I don't change";
  final iAmFinal;
  dynamic iAmDynamic = 1;
  var iAmVar = 1;

  // add your new code here.
  //myConst = "changed const";
  iAmFinal = "My Final Offer";
  //iAmFinal = "I changed my Mind";

  iAmVar = 12345;
  //print(iAmVar);
  //iAmVar = "I am a String now";
  //print(iAmVar);

  iAmDynamic = 12345;
  //print(iAmDynamic);
  iAmDynamic = "string";
  //print(iAmDynamic);
  //print("some text" + myNumber.toString());
  //print("some text $myNumber");

  // 1 Prints out myString and myFloat
  print("$myString $myFloat");

  // 2 Prints myString in all caps
  print(myString.toUpperCase());

  // 3 Rounds myFloat up and down
  print(myFloat.round().toString() + " " + myFloat.truncate().toString());

  // 4 Prints the amount of seconds since 1-1-1970
  final epoch = DateTime.parse('1970-01-01 00:00:00');
  print(epoch.difference(DateTime.now()).inSeconds.abs());

  // 5 Prints the absolute value of -999
  print((-999).abs());

  // 6 Creates a dynamic variable as an int and then changes it to a string
  dynamic variable = 1234;
  print(variable);
  variable = "Hello there";
  print(variable);

  // 7 Prints 1 - 20, modified to print to 10
  for (int i = 0; i < 21; i++) {
    print(i);

    if (i == 10) {
      break;
    }
  }

  // 8 Prints 1 - 20, modified to print to 10
  int x = 0;
  while (x < 21) {
    print(x);

    if (x == 10) {
      break;
    }

    x++;
  }
}