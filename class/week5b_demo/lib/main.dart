import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var armorList = [
    DropdownMenuItem(
      value: "Leather",
      child: Text("Leather"),
    ),
    DropdownMenuItem(
      value: "Chain",
      child: Text("Chain"),
    ),
    DropdownMenuItem(
      value: "Studded",
      child: Text("Studded"),
    ),
    DropdownMenuItem(
      value: "Plate",
      child: Text("Plate"),
    ),
    DropdownMenuItem(
      value: "Scale",
      child: Text("Scale"),
    ),
  ];
  String? selectedArmor = "Plate";

  var weaponList = [
    "Dagger",
    "Sword",
    "Mace",
    "Spear",
    "Club",
  ];
  String? selectedWeapon = "Spear";
  String text01 = "";
  final txtName = TextEditingController();
  final txtDOB = TextEditingController();

  void dumpName() {
    setState(() {
      text01 = txtName.text;
    });
  }

  @override
  void initState() {
    super.initState();
    txtName.text = "ENTER YOUR NAME";
    txtName.addListener(dumpName);
  }

  @override
  void dispose() {
    txtName.dispose();
    txtDOB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Week 5B Demo"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: [
            Text(text01),
            myDropDownRow(),
            //
            // Textfields
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtName,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter Your Name:"),
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 5,
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(200, 200, 100, 200),
                  prefixIcon: Icon(Icons.alarm_on_sharp),
                  suffixIcon: IconButton(
                    onPressed: () {
                      txtName.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    // text01 = value;
                  });
                },
              ),
            ),
            TextField(
              controller: txtDOB,
              textInputAction: TextInputAction.previous,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                label: Text("Date of Birth"),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row myDropDownRow() {
    return Row(
      children: [
        //
        // Weapon List
        //
        DropdownButton(
          items: weaponList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          value: selectedWeapon,
          onChanged: (selected) {
            setState(() {
              selectedWeapon = selected;
            });
          },
        ),
        //
        // Armor List
        //
        DropdownButton(
          items: armorList,
          value: selectedArmor,
          onChanged: (selected) {
            setState(() {
              print(selected);

              selectedArmor = selected;
            });
          },
        ),
      ],
    );
  }
}