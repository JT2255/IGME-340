import 'main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String documentationText = """My proposal for this project was an app that could be used to find and save deals, which I believe I had achieved well. I first started with the deals page, getting a ListView builder
to compile the results I recieved from the api. 
\nOnce I had the deals page working I then started on showing game info. I added an alert dialog containg all of the info for the game aswell as a like button to allow the user to save the games they liked in a seperate area. After that I implemented the search functionality into the app.
\nOnce all of the core functionality was finished, I started work on the design of the app. I picked some colors I liked, and got a new font I thought fit the futuristic theme I was going for well. 
\nI met the requiremnts for this app by creating something I believe to be useful and easy to use. The app makes use of shared_preferences, has more than 1 page, does not crash, has adocumentation page, and has a custom icon, splash screen, and name.
""";

String sourcesText = """
App Icon Asset: flaticon.com
Splash Branding: RIT
Font: Electrolize
""";

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: canvasColor,
        leading: IconButton(
          onPressed: () {
            context.go("/");
          }, 
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text("About", style: TextStyle(fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text(documentationText),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text("Packages", style: TextStyle(fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text("SidebarX, Go_Router, Url_Launcher, Card_Loading, Shared_Preferences, Animated_Search_Bar"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text("Sources", style: TextStyle(fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text(sourcesText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}