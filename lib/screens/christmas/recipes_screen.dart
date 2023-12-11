import 'package:flutter/material.dart';
import 'package:recipes_app/database/recipe_database.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Recipe> recipes = [
      Recipe('Meringue Christmas Wreath', 'assets/christmas/recipe1.jpg'),
      Recipe('Icelandic Laufabrauð', 'assets/christmas/recipe2.jpg'),
      Recipe('Gingerbread Bliss Balls', 'assets/christmas/recipe3.jpg'),
      Recipe('Liquorice Meringue Bites ', 'assets/christmas/recipe4.jpg'),
      Recipe('Christmas Carrot Cake', 'assets/christmas/recipe5.jpg'),
      Recipe('Brown Layer Cake', 'assets/christmas/recipe6.jpg'),
      Recipe('Cream Buns', 'assets/christmas/recipe7.jpg'),
      Recipe('Gingerbread Macarons', 'assets/christmas/recipe8.jpg'),
      Recipe('Black Forest Trifle', 'assets/christmas/recipe9.jpg'),
      Recipe('Gingerbread Christmas Pudding', 'assets/christmas/recipe10.jpg'),
      Recipe('Sticky Toffee Pudding', 'assets/christmas/recipe11.jpg'),
      Recipe('Mini Cranberry Pavlovas', 'assets/christmas/recipe12.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('12 Recipes for Christmas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeItem(recipe: recipe);
        },
      ),
    );
  }
}

class Recipe {
  final String name;
  final String imagePath;

  Recipe(this.name, this.imagePath);
}

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
                recipe: RecipeModel(
              name: recipe.name,
              description: '',
              ingredients: [],
              instructions: '',
              category: '',
              imagePath: recipe.imagePath,
            )),
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
  }
}
