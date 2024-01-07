import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:recipes_app/database/recipe_database.dart';

class RecipeService {
  Future<List<RecipeModel>> loadRecipes() async {
    List<RecipeModel> assetRecipes = await _loadAssetRecipes();
    List<RecipeModel> localRecipes = await loadLocalRecipes();

    return [...assetRecipes, ...localRecipes];
  }

  Future<List<RecipeModel>> _loadAssetRecipes() async {
    String jsonString = await rootBundle.loadString('assets/recipes.json');
    List<dynamic> jsonResponse = json.decode(jsonString);

    List<RecipeModel> recipes = jsonResponse.map((model) => RecipeModel.fromJson(model)).toList();

    return recipes;
  }

  Future<List<RecipeModel>> loadLocalRecipes() async {
    final path = await _localPath;
    final database = RecipeDatabase();
    await database.open();

    return await database.loadAllRecipes();
  }

  Future<void> writeRecipe(RecipeModel newRecipe) async {
    final database = RecipeDatabase();
    await database.open();
    await database.insertRecipe(newRecipe);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}