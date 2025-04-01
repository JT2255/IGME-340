import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Week3APage());
  }
}

class Week3APage extends StatefulWidget {
  const Week3APage({super.key});

  @override
  State<Week3APage> createState() => _Week3APageState();
}

class _Week3APageState extends State<Week3APage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Week3A Demo"),
      backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.blueGrey,
        width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Container(
                  color: const Color.fromARGB(255, 64, 147, 215),
                  width: 200,
                  height: 200,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(20),
                child: Text("Hello World Week 3"),
              ),
              Container(
                color: Colors.yellow,
                width: 300,
                height: 200,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20),
                child: Text("Hello World Week 3"),
              ),
              Container(
                color: Colors.green,
                width: 200,
                height: 200,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20),
                child: Text("Hello World Week 3"),
              ),
              Container(
                color: Colors.red,
                width: 200,
                height: 200,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20),
                child: Text("Hello World Week 3"),
              ),
            ] 
                    ),
          ),
      ),
    );
  }
}
