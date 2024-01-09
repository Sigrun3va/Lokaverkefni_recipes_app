import 'package:flutter/material.dart';
import 'package:recipes_app/model/recipe_model.dart';
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
      body: searchResults.isEmpty
          ? const Center(
        child: Text(
          'No results found',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final recipe = searchResults[index];
          return Card(
            color: const Color(0xFF1C1C1C),
            child: ListTile(
              leading: recipe.imagePath.isNotEmpty
                  ? Image.asset(
                recipe.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.fastfood, color: Colors.white),
              title: Text(
                recipe.name,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                recipe.description,
                style: const TextStyle(color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailsScreen(recipe: recipe),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
