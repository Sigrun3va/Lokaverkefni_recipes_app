import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipes_app/services/recipe_service.dart';
import 'recipe_detail_screen.dart';
import 'package:recipes_app/items/app_bar.dart';
import 'package:recipes_app/model/recipe_model.dart';


class CategoryDetailScreen extends StatefulWidget {
  final String categoryName;
  final int categoryImageIndex;

  const CategoryDetailScreen({
    super.key,
    required this.categoryName,
    required this.categoryImageIndex,
  });

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  List<RecipeModel> recipesForCategory = [];

  @override
  void initState() {
    super.initState();
    loadCategoryRecipes();
  }

  Future<void> loadCategoryRecipes() async {
  try {
    recipesForCategory = await RecipeService().loadRecipesByCategory(widget.categoryName);

    if (recipesForCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No recipes found for this category')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load recipes: $e')),
    );
  } finally {
    setState(() {});
  }
}

 Widget loadImage(String imagePath) {
  if (imagePath.isEmpty || imagePath == 'default') {
    return Image.asset(
      'assets/images/comingsoon.jpg',
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
    );
  } else if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
    return Image.network(
      imagePath,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text('Failed to load network image'));
      },
    );
  } else if (File(imagePath).existsSync()) {
    return Image.file(
      File(imagePath),
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text('Failed to load file image'));
      },
    );
  } else {
    return const Center(child: Text('Invalid image path'));
  }
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
    body: recipesForCategory.isEmpty
        ? const Center(
            child: Text(
              'No recipes found for this category',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: recipesForCategory.length,
            itemBuilder: (context, index) {
              final recipe = recipesForCategory[index];
              Widget imageWidget = loadImage(recipe.imagePath);

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
                      imageWidget,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipe.name,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
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