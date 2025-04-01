import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String postsUrl = "https://jsonplaceholder.typicode.com/posts";

class JItem {
  final int id;
  final String title;

  JItem({required this.id, required this.title});
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List<JItem> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Normal Example'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    List<JItem> retData = await getData();

                    setState(() {
                      data = retData;
                    });
                  },
                  child: Text("Get Data"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      data = [];
                    });
                  },
                  child: Text("Clear Data")
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].id.toString()),
                    subtitle: Text(data[index].title),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<List<JItem>> getData() async {
    List<JItem> posts = [];

    var response = await http.get(Uri.parse(postsUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      for (var item in data) {
        posts.add(
          JItem(
            id: item["id"], 
            title: item["title"]
          )
        );
      }
    }

    return posts;
  }
}
