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

  final txtSearch = TextEditingController();

  String searchUrl = "";
  String trendingUrl = "";
  List searchList = [];
      
  Future getSearch() async {

    searchUrl = "https://api.giphy.com/v1/gifs/search?api_key=qM9S88By2obWaUrW6s1sHjh3AVIXJSdg&q=${txtSearch.text}&limit=10&offset=0&rating=r&lang=en&bundle=messaging_non_clips";
    searchList.clear();
    var response = await http.get(Uri.parse(searchUrl));

    //jsonResp["data"][0]["images"]["original"]["url"]

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      for (final gif in jsonResp["data"]) {
        Map currentGif = {};

        currentGif["url"] = gif["images"]["original"]["url"];
        searchList.add(currentGif);
      }
    } else {
      print("ERROR: $response.statusCode");
    }
  }

  Future getTrending() async {

    trendingUrl = "https://api.giphy.com/v1/gifs/trending?api_key=qM9S88By2obWaUrW6s1sHjh3AVIXJSdg&limit=10&offset=0&rating=r&bundle=messaging_non_clips";
    searchList.clear();
    var response = await http.get(Uri.parse(trendingUrl));

    //jsonResp["data"][0]["images"]["original"]["url"]

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      for (final gif in jsonResp["data"]) {
        Map currentGif = {};

        currentGif["url"] = gif["images"]["original"]["url"];
        searchList.add(currentGif);
      }
    } else {
      print("ERROR: $response.statusCode");
    }
  }

  Future startupList() async {
    await getTrending();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    startupList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Week 7A Demo"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      ),
                  label: Text("Search"),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      txtSearch.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
                controller: txtSearch,
                keyboardType: TextInputType.name,
              ),
            ),
            // Search Button
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await getSearch();
                  setState(() {});
                },
                child: Text("Search"),
              ),
            ),
            // Grid view containing gifs
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 10,
                ),
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return GridTile(
                    child: Center(child: Image.network("${searchList[index]["url"]}")),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
