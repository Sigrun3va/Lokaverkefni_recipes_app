import 'dart:convert';

class RecipeModel {
  final String id;
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

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'] ?? '',
      name: map['name'],
      description: map['description'],
      ingredients: map['ingredients'] is String
          ? List<String>.from(jsonDecode(map['ingredients']))
          : List<String>.from(map['ingredients']),
      instructions: map['instructions'],
      category: map['category'] is String
          ? List<String>.from(jsonDecode(map['category']))
          : List<String>.from(map['category']),
      imagePath: map['imagePath'],
      isUserAdded: map['isUserAdded'] == 1,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': jsonEncode(ingredients),
      'instructions': instructions,
      'category': jsonEncode(category),
      'imagePath': imagePath,
      'isUserAdded': isUserAdded ? 1 : 0,
    };
  }
}