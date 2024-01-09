import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recipes_app/services/recipe_database.dart';
import 'package:recipes_app/model/recipe_model.dart';

class RecipeService {
  final RecipeDatabase _database = RecipeDatabase.instance;


  Future<List<RecipeModel>> loadRecipes() async {
    return await _database.loadRecipes();
  }

  Future<void> writeRecipe(RecipeModel newRecipe) async {
    await _database.insertRecipe(newRecipe);
  }

  Future<void> updateRecipe(RecipeModel updatedRecipe) async {
    await _database.updateRecipe(updatedRecipe);
  }

  Future<void> deleteRecipe(String recipeId) async {
    await _database.deleteRecipe(recipeId);
  }

  Future<List<RecipeModel>> loadRecipesByCategory(String category) async {
    return await _database.loadRecipesByCategory(category);
  }

  Future<List<RecipeModel>> searchRecipes(String query) async {
    return await _database.searchRecipes(query);
  }

  Future<List<RecipeModel>> getChristmasRecipes() async {
    final db = await _database.database;
    final result = await db.rawQuery('''
    SELECT DISTINCT recipes.*
    FROM recipes
    WHERE recipes.category LIKE '%Christmas%'
    LIMIT 12
  ''');
    return result.map((json) => RecipeModel.fromMap(json)).toList();
  }

  Future<RecipeModel?> getRandomRecipe() async {
    return await _database.getRandomRecipe();
  }

  Future<void> addRecipesFromJson() async {
    final jsonString = await rootBundle.loadString('assets/database/recipes.json');
    print(jsonString);
    final List<dynamic> jsonData = jsonDecode(jsonString);
    print(jsonData);
    List<RecipeModel> recipes = jsonData.map((json) => RecipeModel.fromMap(json)).toList();

    for (var recipe in recipes) {
      await _database.insertRecipe(recipe);
    }
  }
}