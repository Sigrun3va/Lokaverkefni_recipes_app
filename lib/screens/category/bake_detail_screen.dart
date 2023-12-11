import 'package:flutter/material.dart';

class BakeDetailScreen extends StatelessWidget {
  final String bakeName;
  final String imagePath;
  final String description;
  final List<String> ingredients;
  final String instructions;

  const BakeDetailScreen({
    Key? key,
    required this.bakeName,
    required this.imagePath,
    required this.description,
    required this.ingredients,
    required this.instructions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bakeName),
      ),
      body: Column(
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              bakeName,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Ingredients:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          // Display ingredients as a list
          for (var ingredient in ingredients)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "- $ingredient",
                style: const TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Instructions:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              instructions, // Display instructions
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
