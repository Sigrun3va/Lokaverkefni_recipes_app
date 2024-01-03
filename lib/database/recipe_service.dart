import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:recipes_app/database/recipe_database.dart';

class RecipeService {
  Future<List<RecipeModel>> loadRecipes() async {
    String jsonString = await rootBundle.loadString('assets/database/recipes.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((model) => RecipeModel.fromJson(model)).toList();
  }
}
