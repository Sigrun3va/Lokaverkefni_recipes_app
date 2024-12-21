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
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients.join(', '),
      'instructions': instructions,
      'category': category.join(', '),
      'imagePath': imagePath,
      'isUserAdded': isUserAdded,
    };
  }

factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'], 
      name: json['name'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: json['instructions'],
      category: List<String>.from(json['category']),
      imagePath: json['imagePath'],
      isUserAdded: json['isUserAdded'],
    );
  }
}