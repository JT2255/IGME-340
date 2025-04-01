import 'package:flutter/material.dart';
import 'my_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: myLightTheme(context),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        appBarTheme: AppBarTheme(),
        textTheme: TextTheme(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: <Widget>[
            Text(
              "Display Large",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Container(
              width: 100,
              height: 100,
              color: Theme.of(context).colorScheme.primary,
              child: Text("Container 01"),
            ),
            Container(
              width: 100,
              height: 100,
              color: Theme.of(context).colorScheme.secondary,
              child: Text("Container 01"),
            ),
            ElevatedButton.icon(
              onPressed: _incrementCounter,
              icon: Icon(Icons.add_location_alt_rounded),
              label: Text("Icon Button"),
              iconAlignment: IconAlignment.start,
            ),
            ElevatedButton(
              onPressed: _incrementCounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.yellow,
                overlayColor: Colors.green,
                textStyle: TextStyle(
                  fontFamily: "Courier",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(1, 2),
                      blurRadius: 20
                    ),
                  ],
                ),
              ),
              child: Text("Button 02"),
            ),
            OutlinedButton(
              onPressed: () {
                _incrementCounter();
              }, 
              child: Text("Outlined 01"),
            ),
            TextButton(
              onPressed: () {

              },
              child: Text("Text Button 01"),
            ),
            const Text(
              'You have pushed the button this many times:',
             /* style: TextStyle(
                fontFamily: "Times",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ), */
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
