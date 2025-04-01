import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

String postsUrl = "https://jsonplaceholder.typicode.com/posts";

class JItem {
  final int id;
  final String title;

  JItem({required this.id, required this.title});
}

class JItemsProvider extends ChangeNotifier {
  List<JItem> items = [];

  Future<void> getData() async {
    var response = await http.get(Uri.parse(postsUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      for (var item in data) {
        items.add(
          JItem(
            id: item["id"], 
            title: item["title"]
          )
        );
      }
    }

    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JItemsProvider>(
      create: (context) {
        return JItemsProvider();
      },
      child: const MaterialApp(
        home: DemoPage(),
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider Example'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<JItemsProvider>(
                  builder: (context, myProvider, child) {
                    return ElevatedButton(
                      onPressed: () {
                        myProvider.getData();
                      },
                      child: Text("Get Data"),
                    );
                  }, 
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<JItemsProvider>().clear();
                  },
                  child: Text("Clear Data")
                ),
              ],
            ),
            Expanded(
              child: Consumer<JItemsProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(value.items[index].id.toString()),
                        subtitle: Text(value.items[index].title),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}