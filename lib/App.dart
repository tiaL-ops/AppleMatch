// lib/app.dart

import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'features/map/map_screen.dart';
import 'features/question/question_screen.dart';
import 'models/tree_model.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/reviews/review_screen.dart';
import 'features/matches/macthes_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newton',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'BubblegumSans',
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // A clean, light background
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF68BAB3),     // Cute Green
          onPrimary: Colors.white,
          secondary: Color(0xFFE57A81),   // Cute Red
          onSecondary: Colors.white,
          error: Color(0xFFE57A81),
          onError: Colors.white,
          background: Color(0xFFF5F5F5),
          onBackground: Colors.black87,
          surface: Colors.white,
          onSurface: Colors.black87,
          tertiary: Color(0xFFCD7D88),    // Dusty Rose accent
        ),
        textTheme: const TextTheme(
          displayMedium: TextStyle(fontSize: 36, color: Colors.black87),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 22),
          bodyMedium: TextStyle(fontSize: 18, height: 1.4),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/map': (context) => const MapScreen(),
        '/matches': (context) => const MatchesScreen(),
        
        '/reviews': (context) => const ReviewScreen(),
         '/questions': (context) => const QuestionScreen(),
        '/favorites': (ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments;
          final favs = args is List<Tree> ? args : <Tree>[];
          return FavoritesScreen(favorites: favs);
        },
      },
    );
  }
}
