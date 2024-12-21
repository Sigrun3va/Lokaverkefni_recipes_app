import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes_app/model/recipe_model.dart';

class RecipeService {
  static const String _baseUrl = 'http://localhost:5045/api/recipes';

  Future<List<RecipeModel>> loadRecipes() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => RecipeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error loading recipes: $e');
    }
  }

  Future<void> writeRecipe(RecipeModel newRecipe) async {
  try {
    final jsonBody = jsonEncode(newRecipe.toJson());
    print('Request body: $jsonBody'); 
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonBody,
    );

    if (response.statusCode != 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to add recipe: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error adding recipe: $e');
  }
}

  Future<void> updateRecipe(RecipeModel updatedRecipe) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${updatedRecipe.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedRecipe.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update recipe: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error updating recipe: $e');
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://localhost:5045/api/recipes/$recipeId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipe: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Error deleting recipe: $e');
  }
}


  Future<List<RecipeModel>> loadRecipesByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?category=$category'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => RecipeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes by category: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error loading recipes by category: $e');
    }
  }

  Future<List<RecipeModel>> searchRecipes(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?search=$query'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => RecipeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search recipes: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error searching recipes: $e');
    }
  }
}
