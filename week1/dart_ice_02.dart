void main() {
  //create list of 0s and replace second position with 1
  var myList1 = [0, 0, 0, 0, 0];
  myList1[1] = 1;
  print(myList1);

  //create growable list with one of each data type
  var myList2 = [];
  myList2.add("string");
  myList2.add(1);
  myList2.add(1.5);
  myList2.add(true);
  print(myList2);

  //insert string into list2
  myList2.insert(1, "IGME");
  print(myList2);

  //create list with 3 strings and add them into list2
  var myList3 = ['item1', 'item2', 'item3'];
  myList2.addAll(myList3);
  print(myList2);

  //create list with new items and insert the list into the front of list2
  var myList4 = [123.4, 'item 6', false];
  myList2.insert(0, myList4);
  print(myList2);

  //create a list of strings
  var myList5 = <String>[];
  myList5.add("string1");
  myList5.add("string2");
  myList5.add("string3");

  //remove 3rd and last item from list5
  myList5.removeAt(2);
  print(myList5);
  myList5.remove(myList5.last);
  print(myList5);

  //remove items 2 - 5 in list2
  myList2.removeRange(1, 5);
  print(myList2);
}