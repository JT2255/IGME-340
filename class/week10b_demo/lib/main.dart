import 'package:flutter/material.dart';
import 'page01.dart';
import 'page02.dart';
import 'page03.dart';
import 'page04.dart';

int curButtomTab = 0;
final bottomNavScreens = [
  // Container(
  //   width: double.infinity,
  //   height: double.infinity,
  //   color: Colors.red,
  //   child: Center(child: Text('Page 01')),
  // ),
  // Container(
  //   width: double.infinity,
  //   height: double.infinity,
  //   color: Colors.yellow,
  //   child: Center(child: Text('Page 02')),
  // ),
  // Container(
  //   width: double.infinity,
  //   height: double.infinity,
  //   color: Colors.purple,
  //   child: Center(child: Text('Page 03')),
  // ),
  Page01(),
  Page02(),
  Page03(),
  Page04(),
];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Week 10B Demo"),
          backgroundColor: Colors.amberAccent,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_boat)),
            ],
          ),
        ),
        // body: TabBarView(
        //   children: [
        //     // Container(
        //     //   width: double.infinity,
        //     //   height: double.infinity,
        //     //   color: Colors.red,
        //     //   child: Center(child: Text('Page 01')),
        //     // ),
        //     // Container(
        //     //   width: double.infinity,
        //     //   height: double.infinity,
        //     //   color: Colors.yellow,
        //     //   child: Center(child: Text('Page 02')),
        //     // ),
        //     // Container(
        //     //   width: double.infinity,
        //     //   height: double.infinity,
        //     //   color: Colors.purple,
        //     //   child: Center(child: Text('Page 03')),
        //     // ),
        //     Page01(),
        //     Page02(),
        //     Page03(),
        //     // Page04(),
        //   ],
        // body: bottomNavScreens[curButtomTab],
        body: IndexedStack(index: curButtomTab, children: bottomNavScreens),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: curButtomTab,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.first_page),
              label: "Home",
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pages),
              label: "Business",
              backgroundColor: Colors.greenAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shelves),
              label: "School",
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
              backgroundColor: Colors.purple,
            ),
          ],
          onTap: (value) {
            setState(() {
              curButtomTab = value;
            });
          },
        ),
      ),
    );
  }
}
