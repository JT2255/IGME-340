import 'deals.dart';
import 'about.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sidebarx/sidebarx.dart';
import 'package:go_router/go_router.dart';
import 'package:card_loading/card_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_search_bar/animated_search_bar.dart';

/// @author: Joe Trovato
/// @version: 1.0.0
/// @since: 2025-04-27
/// 
/// todo: nothing

/// GoRouter setup that allows for page navigation
final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    // main page
    GoRoute(
      path: "/",
      builder: (context, state) => const MainPage(),
    ),
    // documentation page
    GoRoute(
      path: "/about",
      builder: (context, state) => const AboutPage(),
    )
  ]
);

/// colors for app
const primaryColor = Color(0xFF685BFF);
const canvasColor = Color.fromARGB(255, 69, 69, 108);
const scaffoldBackgroundColor = Color.fromARGB(255, 104, 104, 153);
const accentCanvasColor = Color(0xFF3E3E61);



// lists of deals as well as saved info
List dealsList = [];
List favoritesList = [];
late SharedPreferences myPrefs;

/// save favorites data, individual searches do not save as I feel would just add
/// a game to favorites if they want to see it when they open the app later. This 
/// also allows me to have an intuitave way of refreshing the main page game deals
/// by just having them load on startup
Future saveData() async {
  String favoritesMap = json.encode(favoritesList);
  await myPrefs.setString("favorites", favoritesMap);
}


/// main function that starts the program
void main() {
  runApp(const MainApp());
}

/// main class containing theme data and GoRouter config
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        fontFamily: 'Electrolize',
      ),
      routerConfig: router,
    );
  }
}

/// program root calling _MainPageState
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

/// main class of program containing all framework for main page
class _MainPageState extends State<MainPage> {
  // api search link
  String dealsUrl = "https://www.cheapshark.com/api/1.0/deals?storeID=1&AAA=1&pageSize=20&metacritic=5";
  // sidebar controller
  final sidebarController = SidebarXController(selectedIndex: 0, extended: true);
  // searchbar controller 
  final searchController = TextEditingController();
  // divider for sidebar
  final divider = Divider(color: Colors.white.withValues(alpha: 0.3), height: 1);

  /// initialize state
  @override
  void initState() {
    super.initState();
    init();
  }

  /// called when page initializes to get both saved data and refresh game deals
  Future init() async {
    // get favorites
    myPrefs = await SharedPreferences.getInstance();
    String? favorites = myPrefs.getString("favorites");

    if (favorites != null) { favoritesList = jsonDecode(favorites); }

    var response = await http.get(Uri.parse(dealsUrl));

    // clear any old results
    dealsList.clear();
    
    // parse api response to load deals
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      for (final deal in jsonResp) {
        Map currentDeal = {};
        
        // get all info about game and deal
        currentDeal["title"] = deal["title"];
        currentDeal["salePrice"] = deal["salePrice"];
        currentDeal["normalPrice"] = deal["normalPrice"];
        currentDeal["metacriticLink"] = deal["metacriticLink"];
        currentDeal["id"] = deal["dealID"];
        currentDeal["steamID"] = deal["steamAppID"];
        currentDeal["isLiked"] = false;
        
        // check to see if high-res image is available
        var imgCheck = await http.get(Uri.parse("https://cdn.cloudflare.steamstatic.com/steam/apps/${deal["steamAppID"]}/header.jpg"));

        // if high-res available then use it
        if (imgCheck.statusCode == 200) {
          currentDeal["image"] = "https://cdn.cloudflare.steamstatic.com/steam/apps/${deal["steamAppID"]}/header.jpg";
        } else {
          currentDeal["image"] = deal["thumb"];
        }

        // get more deal info for ratings and cheapest price
        var responseInfo = await http.get(Uri.parse("https://www.cheapshark.com/api/1.0/deals?id=${deal["dealID"]}"));

        // parse api response
        if (responseInfo.statusCode == 200) {
          var gameResponse = jsonDecode(responseInfo.body);

          currentDeal["cheapestPrice"] = gameResponse["cheapestPrice"]["price"];
          currentDeal["rating"] = gameResponse["gameInfo"]["steamRatingPercent"];
          currentDeal["ratingCount"] = gameResponse["gameInfo"]["steamRatingCount"];

          // convert time to readable date
          DateTime date = DateTime.fromMillisecondsSinceEpoch(gameResponse["gameInfo"]["releaseDate"] * 1000);
          currentDeal["releaseDate"] = "${date.month}/${date.day}/${date.year}";

          currentDeal["metacriticScore"] = gameResponse["gameInfo"]["metacriticScore"];
        }

        // add game to current list of deals available
        dealsList.add(currentDeal);
      }
    }
    else {
      log("ERROR: ${response.statusCode}");
    }

    setState(() {});
  }

  /// search api for input game
  Future getSearch(value) async {
    var response = await http.get(Uri.parse("https://www.cheapshark.com/api/1.0/games?title=$value&limit=20"));

    // clear old results
    dealsList.clear();

    // parse api response
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      for (final game in jsonResp) {
        Map currentGame = {};

        // get all info about game
        if (game["steamAppID"] != "null") {
          currentGame["title"] = game["external"];
          currentGame["id"] = game["cheapestDealID"];
          currentGame["steamID"] = game["steamAppID"];
          currentGame["cheapestPrice"] = game["cheapest"];
          currentGame["isLiked"] = false;

          // check for high-res image
          var imgCheck = await http.get(Uri.parse("https://cdn.cloudflare.steamstatic.com/steam/apps/${game["steamAppID"]}/header.jpg"));

          // if high-res image available, use it
          if (imgCheck.statusCode == 200) {
            currentGame["image"] = "https://cdn.cloudflare.steamstatic.com/steam/apps/${game["steamAppID"]}/header.jpg";
          } else {
            currentGame["image"] = game["thumb"];
          }

          // get more info about game
          var responseInfo = await http.get(Uri.parse("https://www.cheapshark.com/api/1.0/deals?id=${game["cheapestDealID"]}"));

          if (responseInfo.statusCode == 200) {
            var gameResponse = jsonDecode(responseInfo.body);

            currentGame["salePrice"] = gameResponse["gameInfo"]["salePrice"];
            currentGame["normalPrice"] = gameResponse["gameInfo"]["retailPrice"];
            currentGame["metacriticLink"] = gameResponse["gameInfo"]["metacriticLink"];
            currentGame["rating"] = gameResponse["gameInfo"]["steamRatingPercent"];
            currentGame["ratingCount"] = gameResponse["gameInfo"]["steamRatingCount"];
            currentGame["metacriticScore"] = gameResponse["gameInfo"]["metacriticScore"];

            // if no metacritic score, then format for easier readability
            if (gameResponse["gameInfo"]["metacriticScore"] == "0") {
              currentGame["metacriticScore"] = "N/A";
            }

            // convert time to readable date
            DateTime date = DateTime.fromMillisecondsSinceEpoch(gameResponse["gameInfo"]["releaseDate"] * 1000);
            currentGame["releaseDate"] = "${date.month}/${date.day}/${date.year}";
          }
        }

        // add current game to list
        dealsList.add(currentGame);

        // if game contains no metacritic link or 0 steam ratings, remove it
        // basically cleans out all dlcs and other listings on steam that aren't games
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

  /// primary build function that builds UI for program
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar that also contains search bar
      appBar: AppBar(
        title: AnimatedSearchBar(
          // get title based off of selected sidebar option
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
          // if no text searched then just reset page to refresh main deals and clear searched deals
          onFieldSubmitted: (value) {
            if (value == "") {
              dealsList.clear();
              setState(() {});
              init();
            } else { // allows users to search for things with 2 letters as some games have short titles or users may
                     // not know full name of title
              dealsList.clear();
              setState(() {});
              getSearch(value);
            }           
          },
        ),
        backgroundColor: canvasColor,
      ),
      // return widget based off of selected sidebar option, allowing for easy body swapping
      body: getBodyFromIndex(sidebarController.selectedIndex),
      // sidebar options
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
        // contains all theme data for sidebar and its listed options
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

/// function that returns a body for main scaffold based on sidebar option selected
Widget getBodyFromIndex(int index) {
  switch (index) {
    // deals
    case 0:
      // if no deals present, show loading screen
      if (dealsList.isEmpty) {
        return LoadingBody();
      } else { // show deals once list is populated
        return DealsBody(dealsList: dealsList);
      } 
    // show favorites list 
    case 1:
      return DealsBody(dealsList: favoritesList);
    // returns main body as fallback, does not actually reach here
    case 2:
      return DealsBody(dealsList: dealsList);
    default:
      return Container();  
  }
}

/// function that returns string for appbar title based on sidebar
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

/// short container widget that is shown when no games are in list
/// functions as a loading screen
class LoadingBody extends StatelessWidget {
  const LoadingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                // card loading package makes easy loading blocks
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
  }
}