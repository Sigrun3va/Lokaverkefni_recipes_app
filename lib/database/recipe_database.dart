class RecipeDatabase {
  final List<RecipeModel> recipes = [
    RecipeModel(
      name: 'Chocolate Cake',
      description: 'A delicious chocolate cake recipe.',
      ingredients: ['Chocolate', 'Flour', 'Sugar', 'Eggs'],
      instructions: '1. Mix ingredients...\n2. Bake at 350°F...',
      category: 'Cakes',
      imagePath: 'assets/cakes/chocolate_cake.jpg', // Provide imagePath
    ),
    RecipeModel(
      name: 'Spaghetti Bolognese',
      description: 'Classic spaghetti with meat sauce.',
      ingredients: ['Pasta', 'Ground Beef', 'Tomato Sauce', 'Onions'],
      instructions: '1. Cook pasta...\n2. Brown beef...\n3. Add sauce...',
      category: 'Vegan',
      imagePath: 'assets/pasta/spaghetti_bolognese.jpg', // Provide imagePath
    ),
    // Add more recipes here...
  ];

  List<RecipeModel> getRecipesByCategory(String category) {
    return recipes.where((recipe) => recipe.category == category).toList();
  }
}

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
}