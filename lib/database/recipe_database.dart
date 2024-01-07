import 'dart:convert';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;

class RecipeModel {
  final int id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String instructions;
  final String category;
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

  factory RecipeModel.fromJson(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      ingredients: List<String>.from(jsonDecode(map['ingredients'])),
      instructions: map['instructions'],
      category: map['category'],
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
      'category': category,
      'imagePath': imagePath,
    };
  }
}

class RecipeDatabase {
  late Database _database;

  RecipeDatabase();

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'recipes.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE recipes(id INTEGER PRIMARY KEY, name TEXT, description TEXT, ingredients TEXT, instructions TEXT, category TEXT, imagePath TEXT)',
        );
      },
    );
  }

  Future<int> insertRecipe(RecipeModel recipe) async {
    return await _database.insert('recipes', recipe.toMap());
  }

  Future<List<RecipeModel>> loadExistingRecipes() async {
    String jsonString = await rootBundle.loadString('assets/database/recipes.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((model) => RecipeModel.fromJson(model)).toList();
  }

  Future<List<RecipeModel>> loadNewRecipes() async {
    final List<Map<String, dynamic>> maps = await _database.query('recipes');
    return List.generate(maps.length, (i) {
      return RecipeModel.fromJson(maps[i]);
    });
  }

  Future<List<RecipeModel>> loadAllRecipes() async {
    final List<RecipeModel> existingRecipes = await loadExistingRecipes();
    final List<RecipeModel> newRecipes = await loadNewRecipes();
    return [...existingRecipes, ...newRecipes];
  }
}