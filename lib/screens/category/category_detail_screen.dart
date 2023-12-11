import 'package:flutter/material.dart';
import 'package:recipes_app/database/recipe_database.dart';
import '../../main.dart';
import 'recipe_detail_screen.dart';
import 'package:recipes_app/items/app_bar.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryName;

  const CategoryDetailScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  List<RecipeModel> recipesForCategory = [];

  @override
  void initState() {
    super.initState();
    final categoryRecipes = recipeDatabase.getRecipesByCategory(widget.categoryName);
    setState(() {
      recipesForCategory = categoryRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.categoryName,
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: recipesForCategory.length,
        itemBuilder: (context, index) {
          final recipe = recipesForCategory[index];
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
        },
      ),
    );
  }
}

