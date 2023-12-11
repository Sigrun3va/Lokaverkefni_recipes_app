import 'package:flutter/material.dart';
import 'package:recipes_app/screens/home_screen.dart';
import 'package:recipes_app/database/recipe_database.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

final recipeDatabase = RecipeDatabase();

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baking App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
