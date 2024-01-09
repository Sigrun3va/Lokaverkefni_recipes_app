import 'package:flutter/material.dart';
import 'package:recipes_app/database/recipe_database.dart';
import 'package:recipes_app/database/recipe_service.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<List<RecipeModel>> futureRecipes = RecipeService().getChristmasRecipes();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('12 Recipes for Christmas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<RecipeModel>>(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading recipes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Christmas recipes found'));
          } else {

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final RecipeModel recipe = snapshot.data![index];
                return RecipeItem(recipe: recipe);
              },
            );
          }
        },
      ),
    );
  }
}

class RecipeItem extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeItem({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetailsScreen(recipe: recipe),
        ),
      ),
      child: Card(
        color: const Color(0xFF181818),
        child: Column(
          children: [
            Image.asset(
              recipe.imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.name,
                style: const TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}