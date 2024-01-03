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
}
