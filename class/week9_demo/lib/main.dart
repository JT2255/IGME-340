import 'package:flutter/material.dart';
import 'game.dart';
import 'active.dart';
import 'available.dart';
import 'details.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

final GoRouter _router = GoRouter(
  initialLocation: "/", 
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: "/active",
      builder: (context, state) => const ActiveAbilitiesPage(),
    ),
    GoRoute(
      path: "/available",
      builder: (context, state) => const AvailableAbilitiesPage(),
    ),
    GoRoute(
      path: "/details",
      builder: (context, state) {
        final abilityData = state.extra as Map;
        return DetailsPage(data: abilityData);
      },
    ),
  ]
);

// void main() {
//   runApp(const MainApp());
// }

void main() {
  runApp(
    ChangeNotifierProvider<GameProvider>(
      child: const MainApp(),
      create: (context) {
        return GameProvider();
      },
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: MainPage(),
    // );

    // return MaterialApp(
    //   initialRoute: "/",
    //   routes: {
    //     "/": (context) => MainPage(),
    //     "/active": (context) => ActiveAbilitiesPage(),
    //     "/available": (context) => AvailableAbilitiesPage(),
    //     "/details": (context) => DetailsPage(),
    //   },
    // );

    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
