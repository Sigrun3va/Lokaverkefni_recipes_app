import 'package:flutter/material.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';
import 'package:recipes_app/screens/home_screen.dart';
import 'package:recipes_app/screens/profile/profile_screen.dart';
import 'package:recipes_app/model/recipe_model.dart';
import 'package:recipes_app/services/recipe_service.dart';
import 'package:recipes_app/screens/search/search_results_screen.dart';
import 'dart:math';
import 'package:recipes_app/screens/search/trending_recipes_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 20),
            _buildSearchSuggestion('Surprise Me!', Icons.shuffle, () async {
              final randomRecipe = await getRandomRecipe();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(recipe: randomRecipe),
                ),
              );
            }),
            _buildSearchSuggestion('Most Popular!', Icons.trending_up_rounded, () async {
              final trendingRecipes = await getTrendingRecipes();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TrendingRecipesScreen(trendingRecipes: trendingRecipes),
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _navigateToScreen(index, context, currentIndex),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        backgroundColor: const Color(0xFF181818),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.lightBlue,
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Search for a recipe..',
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: const Icon(Icons.search, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSubmitted: (String value) async {
        final results = await searchRecipes(value);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchResultsScreen(searchResults: results),
          ),
        );
      },
    );
  }
  Widget _buildSearchSuggestion(
      String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<RecipeModel>> searchRecipes(String query) async {
    final recipeService = RecipeService();
    final allRecipes = await recipeService.loadRecipes();
    final queryLower = query.toLowerCase();
    return allRecipes.where((recipe) {
      final recipeLower = recipe.name.toLowerCase();
      return recipeLower.contains(queryLower);
    }).toList();
  }

  Future<List<RecipeModel>> getTrendingRecipes() async {
    final recipeService = RecipeService();
    final allRecipes = await recipeService.loadRecipes();
    final random = Random();

    allRecipes.shuffle();
    return allRecipes.take(10).toList();
  }

  Future<RecipeModel> getRandomRecipe() async {
    final recipeService = RecipeService();
    final allRecipes = await recipeService.loadRecipes();
    final random = Random();
    return allRecipes[random.nextInt(allRecipes.length)];
  }

  void _navigateToScreen(int index, BuildContext context, int currentIndex) {
    if (index == currentIndex) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}