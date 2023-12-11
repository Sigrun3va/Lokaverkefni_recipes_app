import 'package:flutter/material.dart';
import 'package:recipes_app/database/recipe_database.dart'; // Import your Recipe model here

class YourRecipeWidget extends StatelessWidget {
  final RecipeModel recipe;

  const YourRecipeWidget({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(recipe.name),
      // You can add more details here, like description, ingredients, etc.
    );
  }
}
