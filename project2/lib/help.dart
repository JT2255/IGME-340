import 'package:flutter/material.dart';
import 'main.dart';
import 'package:go_router/go_router.dart';

// documentation string
String documentationText = """
  This is my recipe database app that I made as a small utility app I hope to 
  sometimes use on my phone when I want to cook but don't know what to make.

  I first started with an outline of the app, getting basic api calls to work and then
  displaying results with a ListView builder. Once that was working I created the details
  page in order to display the ingredients and instructions of a selected recipe.

  After doing these things, I then implemented GoRouter in order to make page navigation easier, as well
  as adding a navigation bar to the bottom of the screen as I like the ease of its use and how it looks.
  Once the bar and details page functionality was finished, I started work on the help page by creating
  new api calls to get a list of all ingredients and categories you can search for in the api. I then got
  these displaying and finally added this documentation section here.

  After all of this was completed I went back through and made some design edits to all of the pages, changing
  the font of the app and how some text and images displayed to give an overall cleaner look.

  I meet the control requirement by allowing the user to search and filter in 3 different ways for recipes.
  Additionally, all of the users searched content is saved using shared_preferences so even when the app is
  closed it will bring up the most recently searched items.

  Font Used: Nunito
""";


class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => HelpPageState();
}

/// class for diplaying page showing all ingredients and categories as well as documentation
class HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    // nav bar
    return DefaultTabController(
      length: 4, 
      child: Scaffold(
        // app bar containing title
        appBar: AppBar(
          title: Text("Help"),
          backgroundColor: Colors.greenAccent[400],
        ),
        // contains all framework for help page
        body: Container(
          color: Color.fromARGB(255, 183, 230, 181),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ingredients and categories buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ingredients
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 1.5),
                      ),
                      // click on area for list of all ingredients in api
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.egg_outlined, size: 100),
                            Text("List of Ingredients")
                          ],
                        ),
                        // opens dialog box with list of all ingredients
                        onTap: () {
                          showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Ingredients"),
                                content: SingleChildScrollView(
                                  child: Text(ingredients)
                                ),
                                // close dialog
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {Navigator.of(context).pop(); },         
                                    child: Text("Close"), 
                                  ),
                                ],
                              );
                            }
                          );
                        },
                      ),
                    ),
                  ),
                  // categories
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 1.5),
                      ),
                      // click on area for list of all categories in api
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inventory_2_outlined, size: 100),
                            Text("List of Categories")
                          ],
                        ),
                        // opens dialog box with list of all categories
                        onTap: () {
                          showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Categories"),
                                content: SingleChildScrollView(
                                  child: Text(categories)
                                ),
                                // close dialog
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {Navigator.of(context).pop(); },         
                                    child: Text("Close"), 
                                  ),
                                ],
                              );
                            }
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // row contains documentation button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 1.5),
                      ),
                      // click on area for app info
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.question_mark, size: 100),
                            Text("About")
                          ],
                        ),
                        // open dialog about app info
                        onTap: () {
                          showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Documentation"),
                                content: SingleChildScrollView(
                                  child: Text(documentationText, textAlign: TextAlign.left,)
                                ),
                                // close dialog
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {Navigator.of(context).pop(); },         
                                    child: Text("Close"), 
                                  ),
                                ],
                              );
                            }
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
            
            // change page depending on selected button
            switch (value) {
              case 0:
                selectedOption = "Recipe";
                context.go(
                  "/",
                );                 
                break;
              case 1:
                selectedOption = "Ingredient";
                context.go(
                  "/",
                );                
                break;
              case 2:
                selectedOption = "Category";
                context.go(
                  "/",
                );                  
                break;
              case 3:
                // already on help page, do nothing
                break;
              default:
                selectedOption = "Recipe";
                context.go(
                  "/",
                ); 
                break;
            } 
          });
        },
      );
  }
}