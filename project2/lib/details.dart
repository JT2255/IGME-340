import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// class for displaying ingredients and instructions of recipes
class DetailsPage extends StatelessWidget {
  final Map recipe;

  const DetailsPage({super.key, required this.recipe});

  // build ui for recipe
  @override
  Widget build(BuildContext context) {
    // get name and image of recipe
    String recipeName = recipe["name"];
    String recipeImg = recipe["image"];
    String recipeIntstructions = "";

    // if there are instructions in api, get them
    if (recipe["instructions"] != null) {
      recipeIntstructions = recipe["instructions"];
    }

    // game ingredients and measurements for recipe
    List recipeIngredients = recipe["ingredients"];
    List recipeMeasurements = recipe["measurements"];

    String ingredients = "";

    // combine measurements and ingredients into a string
    for (int i = 0; i < recipeIngredients.length; i++) {
      ingredients += "${recipeMeasurements[i].trim()} of ${recipeIngredients[i].trim()}\n";
    }

    return Scaffold(
      // app bar containing name of recipe and button to go back to main page
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Text(recipeName),
        // go back to main page
        leading: IconButton(
          onPressed: () { context.go("/"); }, 
          icon: Icon(Icons.arrow_back)
        ),
      ),
      // container for all api data
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 183, 230, 181),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // header image of recipe
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.zero),
                    border: Border.all(
                      color: Colors.black,
                      width: 2
                    ),
                    image: DecorationImage(image: NetworkImage(recipeImg))
                  ),
                ),
              ),
              // display ingredients
              Text("Ingredients"),
              Text(ingredients),
              // display instructions
              Container(
                width: 300,
                child: Text(recipeIntstructions),
              ),
            ],
          ),
        ),
      ),
    );
  }
}