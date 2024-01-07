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

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<void> writeRecipe(RecipeModel recipe) async {
  final path = await _localPath;
  final file = File('$path/new/new_recipes.json');

  final List<RecipeModel> existingRecipes = await readRecipes();
  existingRecipes.add(recipe);

  String json = jsonEncode(existingRecipes.map((recipe) => recipe.toJson()).toList());
  await file.writeAsString(json);
}

Future<List<RecipeModel>> readRecipes() async {
  try {
    final path = await _localPath;
    final file = File('$path/new/new_recipes.json');
    final contents = await file.readAsString();
    final List<dynamic> jsonData = jsonDecode(contents);
    return jsonData.map((item) => RecipeModel.fromJson(item)).toList();
  } catch (e) {
    return [];
  }
}

Future<String> uploadPhoto(File photo) async {
  final path = await _localPath;
  final imagePath = '$path/${DateTime.now().millisecondsSinceEpoch}.jpg';

  await photo.copy(imagePath);

  return imagePath;
}