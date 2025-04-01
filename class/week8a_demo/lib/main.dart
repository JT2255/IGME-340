import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String bigImg = "https://people.rit.edu/dxcigm/340/assets/images/nms_big.jpg";
  static final myCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: Duration(days: 7),
      maxNrOfCacheObjects: 10,
    ),
  );
  final _txt01 = TextEditingController();
  final _txt02 = TextEditingController();
  late SharedPreferences myPrefs;
  Map jsonToSave = {"searchTerm": "Something", "maxResults": 10, "rating": "G"};
  final String myUrl = "https://www.google.com";

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    myPrefs = await SharedPreferences.getInstance();

    setState(() {
      String? txt1 = myPrefs.getString("name");
      String? txt2 = myPrefs.getString("email");
      String? mapData = myPrefs.getString("mapData");

      if (txt1 != null) _txt01.text = txt1;
      if (txt2 != null) _txt02.text = txt2;
      if (mapData != null) jsonToSave = jsonDecode(mapData);
    });
  }

  Future saveText() async {
    await myPrefs.setString("name", _txt01.text);
    await myPrefs.setString("email", _txt02.text);
    String strMap = json.encode(jsonToSave);
    await myPrefs.setString("mapData", strMap);
  }

  Future restoreText() async {
    setState(() {
      String? txt1 = myPrefs.getString("name");
      String? txt2 = myPrefs.getString("email");

      if (txt1 != null) _txt01.text = txt1;
      if (txt2 != null) _txt02.text = txt2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Week8A demo")),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                TextField(
                  controller: _txt01,
                  decoration: InputDecoration(labelText: "Enter Name"),
                ),
                TextField(
                  controller: _txt02,
                  decoration: InputDecoration(labelText: "Enter Email"),
                ),
                //
                // Buttons
                //
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Uri url = Uri.parse(myUrl);

                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.inAppWebView,
                        )) {
                          throw "Could not launch $url";
                        }
                      },
                      child: Text("Go"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await saveText();
                      },
                      child: Text("Save Text"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await restoreText();
                      },
                      child: Text("Restore Text"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        myCacheManager.emptyCache();
                      },
                      child: Text("Clear Cache"),
                    ),
                  ],
                ),
                // Image.network(
                //   bigImg,
                //   width: 200,
                //   height: 200,
                //   fit: BoxFit.cover,
                //   errorBuilder: (context, error, stackTrace) {
                //     return Icon(Icons.error);
                //   },
                // ),
                // Container(
                //   width: 200,
                //   height: 200,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage(bigImg),
                //       fit: BoxFit.cover,
                //     ),
                //     border: Border.all(color: Colors.black, width: 2),
                //   ),
                // ),
                //
                // Cached Network Images
                //
                CachedNetworkImage(
                  imageUrl: bigImg,
                  cacheManager: myCacheManager,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        bigImg,
                        cacheManager: myCacheManager,
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}