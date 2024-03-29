import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:recipes_app/model/recipe_model.dart';


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

    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE recipes ADD COLUMN isUserAdded INTEGER DEFAULT 0');
    }
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
      imagePath TEXT,
      isUserAdded INTEGER DEFAULT 0
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
    return allRecipes
        .where((recipe) => recipe.category.contains(categoryName))
        .toList();
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

  Future<List<RecipeModel>> loadUserAddedRecipes() async {
    final db = await instance.database;
    final result = await db.query(
      'recipes',
      where: 'isUserAdded = ?',
      whereArgs: [1],
    );
    return result.map((json) => RecipeModel.fromMap(json)).toList();
  }

  Future<void> deleteRecipe(String recipeId) async {
    final db = await instance.database;
    await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [recipeId],
    );
  }
}
