import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/items/bakes_of_the_day_section.dart';
import 'package:recipes_app/items/category_section.dart';
import 'package:recipes_app/database/recipe_service.dart';
import 'package:recipes_app/database/recipe_database.dart';
import 'package:recipes_app/screens/christmas/recipes_screen.dart';
import 'package:recipes_app/screens/profile/add_recipe_screen.dart';
import 'package:recipes_app/screens/profile/profile_screen.dart';
import 'dart:math';
import 'package:recipes_app/screens/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<RecipeModel> recipes = [];
  List<RecipeModel> bakesOfTheDay = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    recipes = await RecipeService().loadRecipes();
    selectBakesOfTheDay();
    setState(() {});
  }

  void selectBakesOfTheDay() {
    final random = Random();
    if (recipes.isNotEmpty) {
      bakesOfTheDay =
          (List<RecipeModel>.from(recipes)..shuffle()).take(5).toList();
    }
  }

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<String> categories = [
    'Cupcakes',
    'Cakes',
    'Bread',
    'Cookies',
    'Pastries',
    'Cheesecakes',
    'Doughnuts',
    'Vegan',
    'Meringue',
    'Frosting & Icing',
    'Savory',
    'Desserts',
    'Seasonal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 450.0,
                floating: false,
                pinned: true,
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/christmas-pavlova.png',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RecipeScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 20.0,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFF181818),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "12 recipes you need to try for Christmas!",
                            style: TextStyle(
                              fontFamily: "HedvigLetterSerif",
                              fontSize: 28,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 2.0, top: 25.0),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CategorySection(
                categories: categories,
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              BakesOfTheDaySection(bakesOfTheDay: bakesOfTheDay),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AddRecipeScreen(categories: categories)));
              },
              backgroundColor: CupertinoColors.tertiarySystemFill,
              child: const Icon(Icons.add, size: 40),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _navigateToScreen(index, context, currentIndex),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        backgroundColor: const Color(0xFF181818),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.lightBlue,
      ),
    );
  }

  void _navigateToScreen(int index, BuildContext context, int currentIndex) {
    if (index == currentIndex) {
      return;
    }

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}