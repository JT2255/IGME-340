import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:card_loading/card_loading.dart';
import 'package:sidebarx/sidebarx.dart';
import 'deals.dart';
import 'about.dart';

/// @author: Joe Trovato
/// @version: 0.6.8
/// @since: 2025-04-21
/// 
/// todo: info page
/// 
/// notes: favorites and deals page mainly finished aside from aesthetics and mailing list
/// going to about page from sidebar will not allow you to navigate back currently

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: "/about",
      builder: (context, state) => const AboutPage(),
    )
  ]
);

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color.fromARGB(255, 69, 69, 108);
const scaffoldBackgroundColor = Color.fromARGB(255, 104, 104, 153);
const accentCanvasColor = Color(0xFF3E3E61);

List dealsList = [];
List favoritesList = [];

final divider = Divider(color: Colors.white.withValues(alpha: 0.3), height: 1);

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
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor
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
  String dealsUrl = "https://www.cheapshark.com/api/1.0/deals?storeID=1&AAA=1&pageSize=20&metacritic=5";
  final sidebarController = SidebarXController(selectedIndex: 0, extended: true); 
  final TextEditingController searchController = TextEditingController();


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

      for (final deal in jsonResp) {
        Map currentDeal = {};
        
        currentDeal["title"] = deal["title"];
        currentDeal["salePrice"] = deal["salePrice"];
        currentDeal["normalPrice"] = deal["normalPrice"];
        currentDeal["metacriticLink"] = deal["metacriticLink"];
        currentDeal["id"] = deal["dealID"];
        currentDeal["steamID"] = deal["steamAppID"];
        currentDeal["isLiked"] = false;
        
        var imgCheck = await http.get(Uri.parse("https://cdn.cloudflare.steamstatic.com/steam/apps/${deal["steamAppID"]}/header.jpg"));

        if (imgCheck.statusCode == 200) {
          currentDeal["image"] = "https://cdn.cloudflare.steamstatic.com/steam/apps/${deal["steamAppID"]}/header.jpg";
        } else {
          currentDeal["image"] = deal["thumb"];
        }

        var responseInfo = await http.get(Uri.parse("https://www.cheapshark.com/api/1.0/deals?id=${deal["dealID"]}"));

        if (responseInfo.statusCode == 200) {
          var gameResponse = jsonDecode(responseInfo.body);

          currentDeal["cheapestPrice"] = gameResponse["cheapestPrice"]["price"];
          currentDeal["rating"] = gameResponse["gameInfo"]["steamRatingPercent"];
          currentDeal["ratingCount"] = gameResponse["gameInfo"]["steamRatingCount"];

          DateTime date = DateTime.fromMillisecondsSinceEpoch(gameResponse["gameInfo"]["releaseDate"] * 1000);
          currentDeal["releaseDate"] = "${date.month}/${date.day}/${date.year}";

          currentDeal["metacriticScore"] = gameResponse["gameInfo"]["metacriticScore"];
        }

        dealsList.add(currentDeal);
      }
    }
    else {
      log("ERROR: ${response.statusCode}");
    }

    setState(() {});
  }

  Future getSearch(value) async {
    var response = await http.get(Uri.parse("https://www.cheapshark.com/api/1.0/games?title=$value&limit=20"));

    dealsList.clear();

    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      for (final game in jsonResp) {
        Map currentGame = {};

        if (game["steamAppID"] != "null") {
          currentGame["title"] = game["external"];
          currentGame["id"] = game["cheapestDealID"];
          currentGame["steamID"] = game["steamAppID"];
          currentGame["cheapestPrice"] = game["cheapest"];
          currentGame["isLiked"] = false;

          var imgCheck = await http.get(Uri.parse("https://cdn.cloudflare.steamstatic.com/steam/apps/${game["steamAppID"]}/header.jpg"));

          if (imgCheck.statusCode == 200) {
            currentGame["image"] = "https://cdn.cloudflare.steamstatic.com/steam/apps/${game["steamAppID"]}/header.jpg";
          } else {
            currentGame["image"] = game["thumb"];
          }

          var responseInfo = await http.get(Uri.parse("https://www.cheapshark.com/api/1.0/deals?id=${game["cheapestDealID"]}"));

          if (responseInfo.statusCode == 200) {
            var gameResponse = jsonDecode(responseInfo.body);

            currentGame["salePrice"] = gameResponse["gameInfo"]["salePrice"];
            currentGame["normalPrice"] = gameResponse["gameInfo"]["retailPrice"];
            currentGame["metacriticLink"] = gameResponse["gameInfo"]["metacriticLink"];
            currentGame["rating"] = gameResponse["gameInfo"]["steamRatingPercent"];
            currentGame["ratingCount"] = gameResponse["gameInfo"]["steamRatingCount"];
            currentGame["metacriticScore"] = gameResponse["gameInfo"]["metacriticScore"];

            if (gameResponse["gameInfo"]["metacriticScore"] == "0") {
              currentGame["metacriticScore"] = "N/A";
            }

            DateTime date = DateTime.fromMillisecondsSinceEpoch(gameResponse["gameInfo"]["releaseDate"] * 1000);
            currentGame["releaseDate"] = "${date.month}/${date.day}/${date.year}";
          }
        }

        dealsList.add(currentGame);

        if (currentGame["metacriticLink"] == "null" || currentGame["ratingCount"] == "0") {
          dealsList.remove(currentGame);
        }
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
        title: AnimatedSearchBar(
          label: getTitleFromIndex(sidebarController.selectedIndex),
          controller: searchController,
          textInputAction: TextInputAction.done,
          autoFocus: false,
          labelStyle: TextStyle(color: Colors.white, fontSize: 25),
          searchStyle: TextStyle(color: Colors.white, fontSize: 25),
          searchDecoration: const InputDecoration(
            hintText: 'Search',
            alignLabelWithHint: false,
            fillColor: Colors.white,
            focusColor: Colors.white,
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) {
            if (value == "") {
              dealsList.clear();
              setState(() {});
              init();
            } else {
              dealsList.clear();
              setState(() {});
              getSearch(value);
            }           
          },
        ),
        backgroundColor: canvasColor,
      ),
      body: getBodyFromIndex(sidebarController.selectedIndex),
      drawer: SidebarX(
        controller: sidebarController,
        items: [
          SidebarXItem(
            icon: Icons.attach_money,
            label: 'Deals',
            onTap: () {
              setState(() {});
            },
          ),
          SidebarXItem(
            icon: Icons.favorite, 
            label: 'Favorites',
            onTap: () {
              setState(() {});
            },
          ),
          SidebarXItem(
            icon: Icons.info, 
            label: 'About',
            onTap: () {
              context.go("/about");
            },
          ),
        ],
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10.0),
          width: 150,
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20.0),
          ),         
          itemTextPadding: const EdgeInsets.only(left: 5),
          selectedItemTextPadding: const EdgeInsets.only(left: 10),
          textStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 20),
          selectedTextStyle: TextStyle(color: Colors.white, fontSize: 21),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: primaryColor.withValues(alpha: 0.37),
            ),
            gradient: const LinearGradient(
              colors: [accentCanvasColor, canvasColor],
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withValues(alpha: 0.7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        footerDivider: divider,
      ),
    );
  }
}

Widget getBodyFromIndex(int index) {
  switch (index) {
    // deals
    case 0:
      if (dealsList.isEmpty) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CardLoading(
                      height: 170,
                      borderRadius: BorderRadius.circular(20),
                      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    );
                  },
                ),
              )
            ],
          ),
        );
      } else {
        return DealsBody(dealsList: dealsList);
      } 
    // favorites
    case 1:
      return DealsBody(dealsList: favoritesList);
    // about
    case 2:
      return Container();
    default:
      return Container();  
  }
}

String getTitleFromIndex(int index) {
  switch (index) {
    case 0:
      return "Game Deals";
    case 1:
      return "Favorites";
    case 2:
      return "About";
    default:
      return "Game Deals";
  }
}