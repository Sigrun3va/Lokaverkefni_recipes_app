import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RecipeModel {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String instructions;
  final List<String> category;
  final String imagePath;

  RecipeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.category,
    required this.imagePath,
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
    };
  }
}

class RecipeDatabase {
  static final RecipeDatabase instance = RecipeDatabase._init();
  static Database? _database;

  RecipeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<bool> recipeExists(String recipeId) async {
    final db = await database;
    final result = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [recipeId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE recipes(
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      ingredients TEXT,
      instructions TEXT,
      category TEXT,
      imagePath TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE categories(
      id INTEGER PRIMARY KEY,
      name TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE recipe_categories(
      recipe_id TEXT,
      category_id INTEGER,
      FOREIGN KEY(recipe_id) REFERENCES recipes(id),
      FOREIGN KEY(category_id) REFERENCES categories(id),
      PRIMARY KEY(recipe_id, category_id)
    )
  ''');
  }

  Future<int> insertRecipe(RecipeModel recipe) async {
    final db = await database;
    return await db.insert(
      'recipes',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRecipe(RecipeModel recipe) async {
    final db = await instance.database;
    await db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<void> deleteRecipe(int id) async {
    final db = await instance.database;
    await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<RecipeModel>> loadRecipes() async {
    final db = await instance.database;
    final result = await db.query('recipes');
    return result.map((json) => RecipeModel.fromMap(json)).toList();
  }

  Future<List<RecipeModel>> searchRecipes(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'recipes',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return result.map((json) => RecipeModel.fromMap(json)).toList();
  }

  Future<List<RecipeModel>> loadRecipesByCategory(String categoryName) async {
    final allRecipes = await loadRecipes();
    return allRecipes.where((recipe) => recipe.category.contains(categoryName)).toList();
  }

  Future<List<RecipeModel>> getChristmasRecipes() async {
    final db = await instance.database;
    final result = await db.query(
      'recipes',
      where: 'category = ?',
      whereArgs: ['Christmas'],
      limit: 12,
    );
    return result.map((json) => RecipeModel.fromMap(json)).toList();
  }

    Future<RecipeModel?> getRandomRecipe() async {
      final db = await instance.database;
      final result = await db.query(
        'recipes',
        orderBy: 'RANDOM()',
        limit: 1,
      );
      if (result.isNotEmpty) {
        return RecipeModel.fromMap(result.first);
      }
      return null;
    }

  }