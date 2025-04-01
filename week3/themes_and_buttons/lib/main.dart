import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.grey[300],
        useMaterial3: true,
        fontFamily: 'Courier',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.red,
            fontSize: 48,
            fontWeight: FontWeight.normal
          ),
          displayMedium: TextStyle(
            color: Colors.red[400],
            fontSize: 36,
            fontWeight: FontWeight.normal
          ),
          displaySmall: TextStyle(
            color: Colors.red[300],
            fontSize: 27,
            fontWeight: FontWeight.normal
          ),
          bodyLarge: TextStyle(
            color: Colors.green,
            fontSize: 48,
            fontWeight: FontWeight.bold
          ),
          bodyMedium: TextStyle(
            color: Colors.green[400],
            fontSize: 36,
            fontWeight: FontWeight.bold
          ),
          bodySmall: TextStyle(
            color: Colors.green[300],
            fontSize: 27,
            fontWeight: FontWeight.bold
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
            foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.error),
            textStyle: WidgetStateProperty.all(TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        scaffoldBackgroundColor: Colors.blueGrey[500],
        fontFamily: 'Courier',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.red,
            fontSize: 48,
            fontWeight: FontWeight.normal
          ),
          displayMedium: TextStyle(
            color: Colors.red[400],
            fontSize: 36,
            fontWeight: FontWeight.normal
          ),
          displaySmall: TextStyle(
            color: Colors.red[300],
            fontSize: 27,
            fontWeight: FontWeight.normal
          ),
          bodyLarge: TextStyle(
            color: Colors.green,
            fontSize: 48,
            fontWeight: FontWeight.bold
          ),
          bodyMedium: TextStyle(
            color: Colors.green[400],
            fontSize: 36,
            fontWeight: FontWeight.bold
          ),
          bodySmall: TextStyle(
            color: Colors.green[300],
            fontSize: 27,
            fontWeight: FontWeight.bold
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary),
            foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
            textStyle: WidgetStateProperty.all(TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
      ),
      home: const MyHomePage(),
      themeMode: ThemeMode.light,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IGME-340: Themes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton.icon(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.black),
                backgroundColor: WidgetStatePropertyAll(Colors.green),
                textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              icon: const Icon(Icons.account_tree_rounded),
              onPressed: () {
                print("Hello 1");
              }, 
              label: const Text('Elevated Button')
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.black),
                backgroundColor: WidgetStatePropertyAll(Colors.green),
                textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20)),
              ),
              onPressed: () {
                print("Hello 2");
              }, 
              child: const Text('Text Button'),
            ),
            OutlinedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.black),
                backgroundColor: WidgetStatePropertyAll(Colors.green),
                textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 10)),
              ),
              onPressed: () {
                print("Hello 3");
              }, 
              child: const Text('Outlined Button'),
            ),
            Container(
              width: 300,
              height: 200,
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                "I am Green",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              width: 200,
              height: 200,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                "I am Yellow",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Container(
              width: 350,
              height: 100,
              color: Theme.of(context).colorScheme.error,
              child: Text(
                "I am Pink",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print("Hello 4");
              },
              child: const Text('Elevated Button'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.black),
                backgroundColor: WidgetStatePropertyAll(Colors.green),
                textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20)),
              ),
              onPressed: () {
                print("Hello 5");
              },
              child: const Text('Elevated Button'),
            ),
          ],
        ),
      ),
    );
  }
}
