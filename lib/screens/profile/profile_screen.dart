import 'package:flutter/material.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';
import 'package:recipes_app/screens/home_screen.dart';
import 'package:recipes_app/screens/search/search_screen.dart';
import 'package:recipes_app/screens/profile/add_recipe_screen.dart';
import 'package:recipes_app/database/global_data.dart';
import 'package:recipes_app/database/recipe_database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<RecipeModel> userAddedRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadUserAddedRecipes();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadUserAddedRecipes() async {
    userAddedRecipes = await RecipeDatabase.instance.loadUserAddedRecipes();
    setState(() {});
  }

  void _deleteRecipe(String recipeId) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this recipe?"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text("Delete"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm) {
      await RecipeDatabase.instance.deleteRecipe(recipeId);
      setState(() {
        userAddedRecipes.removeWhere((recipe) => recipe.id == recipeId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 2;

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: 40,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                    const AddRecipeScreen(categories: GlobalData.categories),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _buildUserProfile(),
            const SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'My Recipes'),
                Tab(text: 'Loved'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMyRecipesTab(),
                  _buildLovedRecipesTab(),
                ],
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
        )
    );
  }

  Widget _buildUserProfile() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/comingsoon.jpg'),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Text(
            'Username',
            style: TextStyle(color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildMyRecipesTab() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: userAddedRecipes.length,
      itemBuilder: (context, index) {
        return _recipeCard(userAddedRecipes[index]);
      },
    );
  }

  Widget _buildLovedRecipesTab() {
    // TODO: loved recipes
    return Container();
  }

  Widget _recipeCard(RecipeModel recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(recipe: recipe),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        color: const Color(0xFF181818),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    recipe.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        recipe.description,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => _deleteRecipe(recipe.id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(int index, BuildContext context, int currentIndex) {
    if (index == currentIndex) {
      return;
    }
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
        break;
    }
  }
}
