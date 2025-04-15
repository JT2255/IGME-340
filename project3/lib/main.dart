import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @author: Joe Trovato
/// @version: 0.2.1
/// @since: 2025-04-14
/// 
/// todo: deals page, info page, sidebar, favorites, game search
/// 
/// notes: none

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MainPage(),
    ),
  ]
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String dealsUrl = "https://www.cheapshark.com/api/1.0/deals?storeID=1&AAA=1";
  List dealsList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    var response = await http.get(Uri.parse(dealsUrl));

    dealsList.clear();

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      // title: "title"
      // sale price: "salePrice"
      // normal price: "normalPrice"
      // image: "thumb"
      for (final deal in jsonResp) {
        Map currentDeal = {};
        
        currentDeal["title"] = deal["title"];
        currentDeal["salePrice"] = deal["salePrice"];
        currentDeal["normalPrice"] = deal["normalPrice"];
        

        var imgCheck = await http.get(Uri.parse("https://cdn.cloudflare.steamstatic.com/steam/apps/${deal["steamAppID"]}/header.jpg"));

        if (imgCheck.statusCode == 200) {
          currentDeal["image"] = "https://cdn.cloudflare.steamstatic.com/steam/apps/${deal["steamAppID"]}/header.jpg";
        } else {
          currentDeal["image"] = deal["thumb"];
        }

        dealsList.add(currentDeal);
      }
    }
    else {
      log("ERROR: ${response.statusCode}");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Deals"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
              colors: [
                Colors.deepPurpleAccent,
                Colors.white
              ]
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dealsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: (context),
                        builder: (context) {
                          return AlertDialog(
                            title: Text("${dealsList[index]["title"]}")
                          );
                        }
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.deepPurpleAccent, width: 2.5),
                          borderRadius: BorderRadius.circular(20.0) 
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17.0),
                              child: SizedBox(
                                height: 150,
                                child: Image.network(
                                  "${dealsList[index]["image"]}",
                                  fit: BoxFit.fill,
                                ),
                              )
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "${dealsList[index]["title"]}".length > 30 ? '${dealsList[index]["title"].substring(0, 27)}...' : '${dealsList[index]["title"]}',
                                    style: TextStyle(
                                      fontSize: 15
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${dealsList[index]["salePrice"]}  ",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    "${dealsList[index]["normalPrice"]}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
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