// ignore_for_file: sized_box_for_whitespace
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'details.dart';
import 'help.dart';

/// @author: Joe Trovato
/// @version: 1.0.0
/// @since: 2025-04-01
/// 
/// todo: nothing
/// 
/// notes: some recipes in the api's database do not have info in them,
/// if you click on a recipe and no instructions pop up, please search
/// for a different recipe that has info in the database.
/// 
/// Pizza Express Margherita is a good example of a well formatted database entry.


/// GoRouter setup that allows for page navigation
final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    // home page
    GoRoute(
      path: "/",
      builder: (context, state) => const MainPage(),
    ),
    // recipe intruction page
    GoRoute(
      path: "/details",
      builder: (context, state) {
        final recipeData = state.extra as Map;
        return DetailsPage(recipe: recipeData);
      },
    ),
    // help / info page
    GoRoute(
      path: "/help",
      builder: (context, state) => const HelpPage(),
    ),
  ]
);

// keep track of bottom nav bar
int curBottomTab = 0;

// selected search option
String selectedOption = "Recipe";

// lists of all possible ingredients and categories
String ingredients = "";
String categories = "";

/// main function that starts program
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        fontFamily: 'Nunito',
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
  // form validation controller
  final formId = GlobalKey<FormState>();
  // search bar controller
  final txtSearch = TextEditingController();
  // save data controller
  late SharedPreferences myPrefs;

  // string to be searched when calling api\
  String searchUrl = "";
  String ingredientUrl = "https://www.themealdb.com/api/json/v1/1/list.php?i=list";
  String catgoryUrl = "https://www.themealdb.com/api/json/v1/1/list.php?c=list";
  // list api results will populate
  List recipeList = [];

  var searchOptions = [
    "Recipe",
    "Ingredient",
    "Category",
  ];

  /// initialize state
  @override
  void initState() {
    super.initState();
    init();
  }

  /// called when page initializes to get saved data and make initial api calls
  Future init() async {
    // get saved search data
    myPrefs = await SharedPreferences.getInstance();

    setState(() {
      String? searchText = myPrefs.getString("search");
      String? category = myPrefs.getString("category");
      String? results = myPrefs.getString("results");

      if (searchText != null) { txtSearch.text = searchText; }
      if (category != null) { selectedOption = category; }
      if (results != null) { recipeList = jsonDecode(results); }
    });

    // call api for list of categories and ingredients
    var categoryCheck = await http.get(Uri.parse(catgoryUrl));
    var ingredientCheck = await http.get(Uri.parse(ingredientUrl));

    // parse api calls
    if (categoryCheck.statusCode == 200 && ingredientCheck.statusCode == 200) { 
      var jsonRespCategory = jsonDecode(categoryCheck.body);
      var jsonRespIngredient = jsonDecode(ingredientCheck.body);

      categories = "";
      ingredients = "";

      // get categories
      if (jsonRespCategory["meals"] != null) {
        for (final category in jsonRespCategory["meals"]) {
          categories += "${category["strCategory"]}, ";
        }
      }

      // get ingredients
      if (jsonRespIngredient["meals"] != null) {
        for (final ingredient in jsonRespIngredient["meals"]) {
          ingredients += "${ingredient["strIngredient"]}, ";
        }
      }
    }
    else {
      log("ERROR: ${categoryCheck.statusCode}, ${ingredientCheck.statusCode}");
    }
  }

  /// save search data
  Future saveData() async {
    await myPrefs.setString("search", txtSearch.text);
    await myPrefs.setString("category", selectedOption);
    String recipeMap = json.encode(recipeList);
    await myPrefs.setString("results", recipeMap);
  }

  /// search api for input recipe, ingredient, or category
  Future getSearch() async {

    // use different search url depending on selected search option
    switch (selectedOption) {
      case "Recipe":
        searchUrl = "https://www.themealdb.com/api/json/v1/1/search.php?s=${txtSearch.text}";
        break;
      case "Ingredient":
        searchUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?i=${txtSearch.text}";
        break;
      case "Category":
        searchUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c=${txtSearch.text}";
        break;
      default:
        searchUrl = "https://www.themealdb.com/api/json/v1/1/search.php?s=${txtSearch.text}";
        break;
    }

    //clear old results
    recipeList.clear();
  
    var response = await http.get(Uri.parse(searchUrl));

    // parse api response to load recipes
    if (response.statusCode == 200) {
      var jsonResp = jsonDecode(response.body);

      // name: "strMeal"
      // instructions: "strInstructions"
      // ingredients: "strIngredientX"
      // ingredient size: "strMeasureX"
      // image: "strMealThumb" 
      if (jsonResp["meals"] != null) {
        for (final recipe in jsonResp["meals"]) {
          Map currentRecipe = {};
          List ingredientList = [];
          List measurementList = [];

          // get recipe name, image, and instructions
          currentRecipe["name"] = recipe["strMeal"];
          currentRecipe["instructions"] = recipe["strInstructions"];
          currentRecipe["image"] = recipe["strMealThumb"];

          for (int i = 1; i < 21; i++) {
            if (recipe["strIngredient$i"] != null && !recipe["strIngredient$i"].isEmpty) {
              ingredientList.add(recipe["strIngredient$i"]);
            }

            if (recipe["strMeasure$i"] != null && !recipe["strMeasure$i"].isEmpty) {
              measurementList.add(recipe["strMeasure$i"]);
            }
          }

          currentRecipe["ingredients"] = ingredientList;
          currentRecipe["measurements"] = measurementList;
          recipeList.add(currentRecipe);
        }
      }

      // save most recent search
      await saveData();
    }
    else {
      log("ERROR: ${response.statusCode}");
    }
  }

  // primary build function that builds UI for program
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // amount of nav bar items
      length: 4,
      child: Scaffold(
        // app bar containing title
        appBar: AppBar(
          title: Text("Recipe Finder"),
          backgroundColor: Colors.greenAccent[400],
        ),
        // contains all framework for main app content
        body: Container(
          color: Color.fromARGB(255, 183, 230, 181),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // text form for validation
              Form(
                key: formId,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    // make sure some text entered into search bar before calling api
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Some Text";
                      } else if (value.length < 3) {
                        return "Not long enough";
                      }
          
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.0,
                          )),
                      label: Text("Search By $selectedOption"),
                      fillColor: Colors.white,
                      filled: true,
                      // clear button in search bar
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
              // contains button to search for recipes
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    // if text form validates, search api for recipes
                    onPressed: () async {
                      if (formId.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await getSearch();
                      }
                      
                      setState(() {});
                    },
                    child: Text("Search"),
                  ),
                ),
              ),
              // framework for displaying all data returned from api
              apiData(),
            ],
          ),
        ),
        // framework for bottom navigation bar
        bottomNavigationBar: bottomNavBar(),
      ),
    );
  }

  // contains all code for navigation bar
  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
        currentIndex: curBottomTab,
        type: BottomNavigationBarType.shifting,
        items: [
          // recipe option
          BottomNavigationBarItem(
            icon: Icon(Icons.dining_outlined, size: 40),
            label: "Recipe",
            backgroundColor: const Color.fromARGB(255, 59, 59, 59)
          ),
          // ingredient option
          BottomNavigationBarItem(
            icon: Icon(Icons.egg_outlined, size: 40),
            label: "Ingredient",
            backgroundColor: const Color.fromARGB(255, 59, 59, 59)
          ),
          // category option
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined, size: 40),
            label: "Category",
            backgroundColor: const Color.fromARGB(255, 59, 59, 59)
          ),
          // help page
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark, size: 40),
            label: "Help",
            backgroundColor: const Color.fromARGB(255, 59, 59, 59)
          ),
        ],
        onTap: (value) {
          setState(() {
            curBottomTab = value; 

            // either set search option or change page depending on selected button
            switch (value) {
              case 0:
                selectedOption = "Recipe";
                break;
              case 1:
                selectedOption = "Ingredient";
                break;
              case 2:
                selectedOption = "Category";
                break;
              case 3:
                // go to help page
                context.go(
                  "/help",
                );
                break;
              default:
                selectedOption = "Recipe";
                break;
            } 
          });
        },
      );
  }

  // contains all code for api data
  Expanded apiData() {
    return Expanded(
      // build containers with recipe data
      child: ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: InkWell(
              // open up full recipe details
              onTap: () {
                context.go(
                  "/details",
                  extra: recipeList[index]
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green, width: 1.5),
                ),
                // display image of each recipe and name
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child:  Image.network("${recipeList[index]["image"]}", ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Flexible(child: Text("${recipeList[index]["name"]}",)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}