import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipes_app/model/recipe_model.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  Widget _buildImageWidget(String? imagePath) {
  if (imagePath == null || imagePath.isEmpty) {
    return Image.asset(
      'assets/images/comingsoon.jpg',
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
    );
  } else if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
    return Image.network(
      imagePath,
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/comingsoon.jpg',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        );
      },
    );
  } else if (imagePath.startsWith('assets')) {
    return Image.asset(
      imagePath,
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/comingsoon.jpg',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        );
      },
    );
  } else {
    return Image.file(
      File(imagePath),
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/comingsoon.jpg',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          recipe.name,
          style: const TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: _buildImageWidget(recipe.imagePath),
            ),
            const SizedBox(height: 1.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 25.0),
              decoration: BoxDecoration(
                color: const Color(0xFF181818),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                recipe.name,
                style: const TextStyle(
                  fontFamily: "HedvigLetterSerif",
                  fontSize: 28,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                recipe.description,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Ingredients:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              children: recipe.ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: Text(
                    ingredient,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.instructions.split('\n').map((instruction) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                  child: Text(
                    instruction.trim(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
