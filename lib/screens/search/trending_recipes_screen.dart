import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipes_app/model/recipe_model.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';

class TrendingRecipesScreen extends StatelessWidget {
  final List<RecipeModel> trendingRecipes;

  const TrendingRecipesScreen({Key? key, required this.trendingRecipes}) : super(key: key);

  Widget _buildImageWidget(String imagePath) {
    if (imagePath.isEmpty) {
      return const Icon(Icons.fastfood, color: Colors.white, size: 50);
    } else if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return Image.network(
        imagePath,
        width: 100,
        height: 150,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('assets')) {
      return Image.asset(
        imagePath,
        width: 100,
        height: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        width: 100,
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rising Star Bakes', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: trendingRecipes.isEmpty
          ? const Center(
        child: Text(
          'No trending recipes available',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: trendingRecipes.length,
        itemBuilder: (context, index) {
          final recipe = trendingRecipes[index];
          return Card(
            color: const Color(0xFF1C1C1C),
            child: ListTile(
              leading: _buildImageWidget(recipe.imagePath),
              title: Text(
                '${index + 1}. ${recipe.name}',
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
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