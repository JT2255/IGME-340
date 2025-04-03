import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// @author: Joe Trovato
/// @version: 1.0.0
/// @since: 2025-02-10
/// 
/// todo: 
/// nothing
/// 
/// notes:
/// this project is based on 235's design to spec project

/// main function that starts the program
void main() {
  runApp(const MainApp());
}
// END main

/// main colors used throughout project
var mainBackColor = Color.fromARGB(255, 53, 53, 61);
var textBackColor = Color.fromARGB(255, 104, 104, 104);
var appBarColor = Color.fromARGB(255, 161, 159, 162);
var gradDarkColor = Color.fromARGB(255, 55, 73, 71);
var gradLightColor = Color.fromARGB(255, 130, 140, 142);
var itemBackColor = Color.fromARGB(255, 50, 77, 68);

/// placeholder texts for menus
var loremTextMed = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce maximum dolor quis mi faucibus luctus."
  "\n\nAenean blandit quam felis. Phasellus id dui quis eros accumsan malesuada eu ac tortor." 
  "\n\nIn posuere, libero vel faucibus elementum, mi orci sagittis nisl, vitae aliquam magna metus quis elit. Donec eu imperdiet dui.";

var loremTextLong = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce maximum dolor quis mi faucibus luctus."
  "Aenean blandit quam felis. Phasellus id dui quis eros accumsan malesuada eu ac tortor." 
  "\n\nIn posuere, libero vel faucibus elementum, mi orci sagittis nisl, vitae aliquam magna metus quis elit. Donec eu imperdiet dui."
  " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce maximum dolor quis mi faucibus luctus."
  "Aenean blandit quam felis. Phasellus id dui quis eros accumsan malesuada eu ac tortor." 
  "\n\nIn posuere, libero vel faucibus elementum, mi orci sagittis nisl, vitae aliquam magna metus quis elit. Donec eu imperdiet dui.";

/// main class containing theme data
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // theme data for different texts in program
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project 01',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: 15, 
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontFamily: "Retro",
            fontSize: 15,
            fontWeight: FontWeight.bold, 
            color: Colors.white
          ),
          headlineLarge: TextStyle(
            fontFamily: "Retro", 
            fontSize: 20, 
            color: Colors.white
          ),
          labelMedium: TextStyle(
            fontFamily: "Retro", 
            fontSize: 10, 
            color: Colors.black
          ),
          labelLarge: TextStyle(
            fontFamily: "Retro", 
            fontSize: 20, 
            color: Colors.black
          ),
          bodySmall: TextStyle(
            fontFamily: "Retro",
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// root of program calling _HomePageState
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// main class of program containing all framework and code
class _HomePageState extends State<HomePage> {
  @override
  // primary build function that builds UI for program
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      // app bar containing logo, title, and about button that shows credits
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: SvgPicture.asset(
            "assets/images/pickaxe.svg", 
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)
          ),
        ),
        title: Text("Trees & Wood", style: TextStyle(fontFamily: "Retro", color: Colors.white)),
        actions: [
          Padding(
            padding: EdgeInsets.all(1),
            child: IconButton(
              onPressed: () {
                // bring up credits dialog box
                showDialog(
                  barrierDismissible: false,
                  context: (context),
                  builder: (context) {
                    return AlertDialog(
                      title: Text("About"),
                      content: Text("Created By Joe Trovato \n\nBased on the work done in 235's design to spec homework. \n\nFebruary 2025"),
                      contentTextStyle: Theme.of(context).textTheme.labelMedium,
                      titleTextStyle: Theme.of(context).textTheme.labelLarge,
                      actions: [
                        ElevatedButton(
                          onPressed: () {Navigator.of(context).pop(); },         
                          child: Text("Ok", style: TextStyle(fontFamily: "Retro", fontSize: 15)), 
                        ),
                      ],
                    );
                  },
                );
              }, 
              icon: Icon(Icons.account_circle_rounded),
            ),
          ),
        ],
        actionsIconTheme: IconThemeData(
          size: 25,
        ),
      ),
      // contains all framework for main app content
      body: Stack(
        children: [
          // container for app background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/valley.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // scroll container for all content of app
          SingleChildScrollView(
            child: Column(
              children: [
                // contains tree image and gradient
                Container(
                  width: screenWidth,
                  height: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        gradLightColor,
                        gradDarkColor,
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    image: DecorationImage(
                      scale: 1.8,
                      fit: BoxFit.scaleDown,
                      image: AssetImage("assets/images/oaktree.png")
                    ),
                  ),
                ),
                // contains description text for oak tree photo
                Container(
                  width: screenWidth,
                  color: textBackColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "The Oak Tree",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce maximum dolor quis mi faucibus luctus."
                          "\n\nAenean blandit quam felis. Phasellus id dui quis eros accumsan malesuada eu ac tortor." 
                          "\n\nIn posuere, libero vel faucibus elementum, mi orci sagittis nisl, vitae aliquam magna metus quis elit. Donec eu imperdiet dui.\n ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                // spacing box
                SizedBox(
                  height: 375,
                ),
                // contains rows of items including planks, sticks, chests, and stairs
                Container(
                  color: mainBackColor,
                  child: Column(
                    children: [
                      Row( // Planks Row
                      // contains all framework for planks including images, text, and popups
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: (context),
                                builder: (context) {
                                  // plank info dialog box
                                  return AlertDialog(
                                    title: Text("Planks"),
                                    backgroundColor: textBackColor,
                                    content: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: itemBackColor,
                                              height: 275,
                                              child: Image.asset("assets/images/planks.png"),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Text(loremTextLong),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    contentTextStyle: Theme.of(context).textTheme.labelMedium,
                                    titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                                    actions: [
                                      ElevatedButton(
                                      onPressed: () {Navigator.of(context).pop(); },         
                                      child: Text("Close", style: TextStyle(fontFamily: "Retro", fontSize: 15)), 
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                  color: itemBackColor,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                      child: Text("Planks", style: Theme.of(context).textTheme.bodySmall,),
                                    ),
                                    Image.asset(
                                      "assets/images/planks.png",
                                      fit: BoxFit.scaleDown,
                                      scale: 3.8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth - 145,
                            height: 125,
                            color: textBackColor,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: SingleChildScrollView(
                                child: Text(
                                  loremTextMed,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row( // Sticks Row
                      // contains all framework for sticks including images, text, and popups
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: (context),
                                builder: (context) {
                                  // stick info dialog box
                                  return AlertDialog(
                                    title: Text("Sticks"),
                                    backgroundColor: textBackColor,
                                    content: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: itemBackColor,
                                              width: 300,
                                              height: 200,
                                              child: Image.asset("assets/images/stick.png"),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Text(loremTextLong),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    contentTextStyle: Theme.of(context).textTheme.labelMedium,
                                    titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                                    actions: [
                                      ElevatedButton(
                                      onPressed: () {Navigator.of(context).pop(); },         
                                      child: Text("Close", style: TextStyle(fontFamily: "Retro", fontSize: 15)), 
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                  color: itemBackColor,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                      child: Text("Sticks", style: Theme.of(context).textTheme.bodySmall,),
                                    ),
                                    Image.asset(
                                      "assets/images/stick.png",
                                      fit: BoxFit.scaleDown,
                                      scale: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth - 145,
                            height: 125,
                            color: textBackColor,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: SingleChildScrollView(
                                child: Text(
                                  loremTextMed,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), 
                      Row( // Chests Row
                      // contains all framework for chests including images, text, and popups
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: (context),
                                builder: (context) {
                                  // chest info dialog box
                                  return AlertDialog(
                                    title: Text("Chests"),
                                    backgroundColor: textBackColor,
                                    content: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: itemBackColor,
                                              height: 250,
                                              child: Image.asset("assets/images/chest.png"),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Text(loremTextLong),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    contentTextStyle: Theme.of(context).textTheme.labelMedium,
                                    titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                                    actions: [
                                      ElevatedButton(
                                      onPressed: () {Navigator.of(context).pop(); },         
                                      child: Text("Close", style: TextStyle(fontFamily: "Retro", fontSize: 15)), 
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                  color: itemBackColor,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                      child: Text("Chests", style: Theme.of(context).textTheme.bodySmall,),
                                    ),
                                    Image.asset(
                                      "assets/images/chest.png",
                                      fit: BoxFit.scaleDown,
                                      scale: 3.7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth - 145,
                            height: 125,
                            color: textBackColor,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: SingleChildScrollView(
                                child: Text(
                                  loremTextMed,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), 
                      Row( // Stairs Row
                      // contains all framework for stairs including images, text, and popups
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: (context),
                                builder: (context) {
                                  return AlertDialog(
                                    // stair info dialog box
                                    title: Text("Stairs"),
                                    backgroundColor: textBackColor,
                                    content: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: itemBackColor,
                                              height: 275,
                                              child: Image.asset("assets/images/stairs.png"),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Text(loremTextLong),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    contentTextStyle: Theme.of(context).textTheme.labelMedium,
                                    titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                                    actions: [
                                      ElevatedButton(
                                      onPressed: () {Navigator.of(context).pop(); },         
                                      child: Text("Close", style: TextStyle(fontFamily: "Retro", fontSize: 15)), 
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                  color: itemBackColor,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                      child: Text("Stairs", style: Theme.of(context).textTheme.bodySmall,),
                                    ),
                                    Image.asset(
                                      "assets/images/stairs.png",
                                      fit: BoxFit.scaleDown,
                                      scale: 3.2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth - 145,
                            height: 125,
                            color: textBackColor,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: SingleChildScrollView(
                                child: Text(
                                  loremTextMed,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),   
                    ],
                  ),
                ),
                // white seperation bar
                Container(
                  width: screenWidth,
                  color: Colors.white,
                  height: 10,
                ),
                // contains bottom image and text
                Container(
                  height: 250,
                  width: screenWidth,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/trees.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Trees are pretty cool.\nRight?", 
                        textAlign: TextAlign.center, 
                        style: Theme.of(context).textTheme.headlineMedium
                      ),
                      Container(
                        height: 212,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Copyright 2025\nRIT School of Interactive Games\nAnd Media",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // END build
}
// END _HomePageState