import 'package:flutter/material.dart';
import 'package:recipes_app/database/recipe_database.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final List<RecipeModel> searchResults;

  const SearchResultsScreen({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final recipe = searchResults[index];
          return ListTile(
            title: Text(recipe.name, style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(recipe: recipe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
