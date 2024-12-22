import 'dart:convert';

class RecipeModel {
  final int id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String instructions;
  final List<String> category;
  final String imagePath;
  final bool isUserAdded;

  RecipeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.category,
    required this.imagePath,
    this.isUserAdded = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'ingredientsJson': jsonEncode(ingredients),
      'categoryJson': jsonEncode(category),
      'instructions': instructions,
      'imagePath': imagePath,
      'isUserAdded': isUserAdded,
    };
  }

 factory RecipeModel.fromJson(Map<String, dynamic> json) {
  return RecipeModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    ingredients: json['ingredientsJson'] != null
        ? List<String>.from(jsonDecode(json['ingredientsJson']))
        : [],
    instructions: json['instructions'],
    category: json['categoryJson'] != null
        ? List<String>.from(jsonDecode(json['categoryJson']))
        : [],
    imagePath: json['imagePath'] ?? 'assets/images/comingsoon.jpg',
    isUserAdded: json['isUserAdded'],
  );
}
}