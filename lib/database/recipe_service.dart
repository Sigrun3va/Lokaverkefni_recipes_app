import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:recipes_app/database/recipe_database.dart';
import 'package:path_provider/path_provider.dart';

class RecipeService {
  Future<List<RecipeModel>> loadRecipes() async {
    String jsonString = await rootBundle.loadString('assets/database/recipes.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((model) => RecipeModel.fromJson(model)).toList();
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> _loadAssetRecipes() async {
    return await rootBundle.loadString('assets/database/recipes.json');
  }

  Future<String> _loadNewRecipes() async {
    final path = await _localPath;
    final file = File('$path/new/new_recipes.json');
    return await file.readAsString();
  }
}