import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text01 = "Button 01";
  String text02 = "Button 02";
  String text03 = "Button 03";
  int count01 = 0;
  int count02 = 0;
  int count03 = 0;
  String netImage = "https://images.squarespace-cdn.com/content/v1/5b0e8599af2096a0df635bd1/1540855355984-EF5J68NF0BH0I4LA1QW5/Gudetama-2016-sigh+no+background+.png?format=1500w";

  pressEB01() {
    setState(() {
      count01 = count01 + 1;
      text01 = "I was clicked $count01 times";
    });
  }

  pressEB02() {
    count02 = count02 + 1;
    text02 = "I was clicked $count02 times";
  }

  pressEB03() {
    count03 = count03 + 1;
    text03 = "I was clicked $count03 times";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Button Demo"),
          backgroundColor: Color.fromARGB(255, 42, 190, 180),
          elevation: 20,       
          //leading: Image.network(netImage),
          leading: Image.asset("assets/images/red.jpg"),
          // leading: Padding(
          //   padding: EdgeInsets.only(left: 5, right: 20),
          //   child:
          //       Icon(Icons.handyman, color: Colors.amber, size: 30, shadows: [
          //     Shadow(
          //       color: Colors.black,
          //       blurRadius: 20,
          //       offset: Offset(5, 5),
          //     )
          //   ]),
          // ),
          actions: [
            IconButton(
              onPressed: () {
                pressEB01();
              },
              icon: Icon(Icons.add_a_photo),
            ),
            IconButton(
              onPressed: () {
                pressEB01();
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                pressEB01();
              },
              icon: Icon(Icons.email),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(netImage, width: 50, height: 50),
              Image(
                width: 100,
                height: 100,
                image: AssetImage("assets/images/red.jpg"),
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/red.jpg")),
                  color: Colors.red[50],
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 20,
                      offset: Offset(5, 5)),
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(netImage)),
                  color: Colors.blue[50],
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 20,
                      offset: Offset(5, 5)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: pressEB01,
                child: Text("Button 01"),
              ),
              ElevatedButton(
                onPressed: pressEB02,
                child: Text("Button 02"),
              ),
              ElevatedButton(
                onPressed: () {
                  pressEB03();
                },
                child: Text("Button 03"),
              ),
              Container(
                width: double.infinity,
                height: 5,
                color: Colors.green,
              ),
              Text(text01),
              Text(text02),
              Text(text03),
            ],
          ),
        ));
  }
}
