import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List cartsList = [];

  Future doTheThing() async {
    String url = "https://dummyjson.com/carts";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);
      for (final cart in jsonResp["carts"]) {
        Map curCart = {};
        curCart["userId"] = cart["userId"];
        curCart["total"] = cart["total"];
        curCart["products"] = cart["totalProducts"];

        cartsList.add(curCart);
      }
    } else {
      print("ERROR: $response.statusCode");
    }
  }

  Future doStartupStuff() async {
    print("Starting up");
    await doTheThing();
    setState(() {});
    print("Got Stuff");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    doStartupStuff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Week6B demo"), backgroundColor: Colors.amber),
      body: Center(
        child: Column(
          spacing: 20,
          children: [
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await doTheThing();
                setState(() {});
              },
              child: Text("Get Some Data"),
            ),
            Expanded(
              child: Container(
                color: Colors.blueGrey,
                child: ListView.builder(
                  itemCount: cartsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: Colors.amber[50],
                      minVerticalPadding: 5,
                      title: Text("${cartsList[index]["userId"]}"),
                      subtitle: Text("${cartsList[index]["products"]}"),
                      trailing: Text("\$ ${cartsList[index]["total"]}"),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
