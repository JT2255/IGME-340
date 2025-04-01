import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(fontFamily: "Electric"),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final txtSearch = TextEditingController();
  final formId = GlobalKey<FormState>();

  String searchUrl = "";
  String trendingUrl = "";
  String randomUrl = "";
  String? selectedNum = "10";
  List gifList = [];

  var numGifs = [
    "1",
    "5",
    "10",
    "20",
    "30",
  ];

  // search for gifs based on user input
  Future getSearch() async {
    searchUrl =
        "https://api.giphy.com/v1/gifs/search?api_key=qM9S88By2obWaUrW6s1sHjh3AVIXJSdg&q=${txtSearch.text}&limit=$selectedNum&offset=0&rating=r&lang=en&bundle=messaging_non_clips";
    gifList.clear();
    var response = await http.get(Uri.parse(searchUrl));

    //jsonResp["data"][0]["images"]["original"]["url"]

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      for (final gif in jsonResp["data"]) {
        Map currentGif = {};

        currentGif["url"] = gif["images"]["original"]["url"];
        currentGif["link"] = gif["url"];
        currentGif["title"] = gif["title"];
        currentGif["rating"] = gif["rating"];
        currentGif["height"] = gif["images"]["original"]["height"];
        gifList.add(currentGif);
      }
    } else {
      log("ERROR: $response.statusCode");
    }
  }

  // load trending gifs
  Future getTrending() async {
    trendingUrl =
        "https://api.giphy.com/v1/gifs/trending?api_key=qM9S88By2obWaUrW6s1sHjh3AVIXJSdg&limit=$selectedNum&offset=0&rating=r&bundle=messaging_non_clips";
    gifList.clear();
    var response = await http.get(Uri.parse(trendingUrl));

    //jsonResp["data"][0]["images"]["original"]["url"]

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      for (final gif in jsonResp["data"]) {
        Map currentGif = {};

        currentGif["url"] = gif["images"]["original"]["url"];
        currentGif["link"] = gif["url"];
        currentGif["title"] = gif["title"];
        currentGif["rating"] = gif["rating"];
        currentGif["height"] = gif["images"]["original"]["height"];
        gifList.add(currentGif);
      }
    } else {
      log("ERROR: $response.statusCode");
    }
  }

  // load random gif
  Future getRandom() async {
    randomUrl =
        "https://api.giphy.com/v1/gifs/random?api_key=qM9S88By2obWaUrW6s1sHjh3AVIXJSdg&tag=&rating=pg-13";
    gifList.clear();
    var response = await http.get(Uri.parse(randomUrl));

    //jsonResp["data"][0]["images"]["original"]["url"]

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      Map currentGif = {};

      currentGif["url"] = jsonResp["data"]["images"]["original"]["url"];
      currentGif["link"] = jsonResp["data"]["url"];
      currentGif["title"] = jsonResp["data"]["title"];
      currentGif["rating"] = jsonResp["data"]["rating"];
      currentGif["height"] = jsonResp["data"]["images"]["original"]["height"];
      gifList.add(currentGif);
    } else {
      log("ERROR: $response.statusCode");
    }
  }

  // load trending gifs on app startup
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
        title: Text("Giphy Finder"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          children: [
            //
            // Search Bar Form and Validation
            //
            Form(
              key: formId,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Some Text";
                    } else if (value.length < 3) {
                      return "Not long enough";
                    }

                    return null;
                  },
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
            ),
            //
            // Dropdown for number of gifs
            //
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Container(
                height: 55,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                child: DropdownButton(
                  isExpanded: true,
                  items: numGifs.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  value: selectedNum,
                  onChanged: (selected) {
                    setState(() {
                      selectedNum = selected;
                    });
                  },
                ),
              ),
            ),
            //
            // Search, Reset, and Random Button
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formId.currentState!.validate()) {
                        await getSearch();
                      }
                      
                      setState(() {});
                    },
                    child: Text("Search"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await getRandom();
                      setState(() {});
                    },
                    child: Text("Random"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      gifList.clear();
                      selectedNum = "10";
                      txtSearch.clear();
                      setState(() {});
                    },
                    child: Text("Reset"),
                  ),
                ),
              ],
            ),
            Text("Gifs Found: ${gifList.length}"),
            //
            // Grid view containing gifs
            //
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 10,
                ),
                itemCount: gifList.length,
                itemBuilder: (context, index) {
                  return GridTile(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height:
                                      double.parse(gifList[index]["height"]) +
                                          25,
                                  child: Column(
                                    children: [
                                      Image.network("${gifList[index]["url"]}"),
                                      Text("Title: ${gifList[index]["title"]}"),
                                      Text(
                                          "Rating: ${gifList[index]["rating"].toString().toUpperCase()}"),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      launchUrlString(
                                          "${gifList[index]["link"]}");
                                    },
                                    child: Text("Open GIPHY"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Close"),
                                  )
                                ],
                              );
                            });
                      },
                      child: Center(
                        child: Image.network("${gifList[index]["url"]}"),
                      ),
                    ),
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
