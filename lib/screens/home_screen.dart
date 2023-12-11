import 'package:flutter/material.dart';
import 'package:recipes_app/items/category_item.dart';
import 'package:recipes_app/screens/christmas/recipes_screen.dart';
import 'package:recipes_app/screens/category/category_detail_screen.dart';
import 'package:recipes_app/screens/category/bake_detail_screen.dart';

class HomeScreen extends StatelessWidget {
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

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 450.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
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
                          '12 Recipes you need to try for Christmas!',
                          style: TextStyle(
                            fontFamily: 'HedvigLettersSerif',
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CategoryDetailScreen(
                            categoryName: categories[index],
                          ),
                        ),
                      );
                    },
                    child: CategoryItem(
                      imagePath: 'assets/images/${index + 1}.png',
                      categoryName: categories[index],
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 10.0, bottom: 8.0),
              child: Text(
                'Bakes of the Day!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BakeDetailScreen(
                            bakeName: 'Bake ${index + 1}',
                            imagePath: 'assets/images/comingsoon.jpg',
                            description: 'Description for Bake ${index + 1}',
                            ingredients: const ['Ingredient 1', 'Ingredient 2'],
                            instructions: 'Instructions for Bake ${index + 1}',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Card(
                        color: const Color(0xFF181818),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/comingsoon.jpg',
                              width: 200,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Bake ${index + 1}',
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
}
