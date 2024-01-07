import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RecipeModel {
  final String name;
  final String description;
  final List<String> ingredients;
  final String instructions;
  final String category;
  final String imagePath;

  RecipeModel({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.category,
    required this.imagePath,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      name: json['name'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: json['instructions'],
      category: json['category'],
      imagePath: json['imagePath'],
    );
  }

    Map<String, dynamic> toJson() {
      return {
        'name': name,
        'description': description,
        'ingredients': ingredients,
        'instructions': instructions,
        'category': category,
        'imagePath': imagePath,
      };
    }
  }

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/recipes.json');
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> writeRecipes(List<RecipeModel> recipes) async {
  final file = await _localFile;
  String json = jsonEncode(recipes.map((recipe) => recipe.toJson()).toList());
  return file.writeAsString(json);
}