import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("IGME-340 Basic App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.yellow,
              height: 200,
              alignment: Alignment.center,
              child: Text("Item 1"),
            ),
            Container(
              color: Colors.red,
              height: 200,
              alignment: Alignment.center,
              child: Text("Item 2"),
            ),
            Container(
              color: Colors.blue,
              height: 200,
              alignment: Alignment.center,
              child: Text("Item 3"),
            ),
            Container(
              color: Colors.greenAccent,
              height: 200,
              alignment: Alignment.center,
              child: Text("Item 4"),
            ),
            Container(
              color: Colors.pink[700],
              height: 200,
              alignment: Alignment.center,
              child: Text("Item 5"),
            ),
            Container(
              color: Colors.blue[100],
              height: 200,
              alignment: Alignment.center,
              child: Text("Item 6"),
            ),
            Container(
              color: Colors.grey,
              height: 200,
              alignment: Alignment.center,
              child: Text("Item 7"),
            ),
            Container(
              color: Colors.lightGreen,
              height: 200,
              alignment: Alignment.center,
              child: Text("Item 8"),
            ),
          ],
        ),
      ),
    );
  }
}

