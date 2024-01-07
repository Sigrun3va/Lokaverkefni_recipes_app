import 'package:flutter/material.dart';
import 'package:recipes_app/database/recipe_database.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';

class RecipeItem extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeItem({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(recipe: recipe),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  recipe.imagePath,
                  fit: BoxFit.cover,
                  semanticLabel: 'Recipe Image',
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.name,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}