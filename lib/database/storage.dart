import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:recipes_app/database/recipe_database.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/assets/database/recipes.json');
}

Future<File> writeRecipe(List<RecipeModel> recipes) async {
  final file = await _localFile;
  return file.writeAsString(jsonEncode(recipes));
}

Future<List<RecipeModel>> readRecipes() async {
  try {
    final file = await _localFile;
    final contents = await file.readAsString();
    final List<dynamic> jsonData = jsonDecode(contents);
    return jsonData.map((item) => RecipeModel.fromJson(item)).toList();
  } catch (e) {

    return [];
  }
}
