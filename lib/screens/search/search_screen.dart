import 'package:flutter/material.dart';
import 'package:recipes_app/screens/home_screen.dart';
import 'package:recipes_app/screens/profile/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildSearchSuggestion('Surprise Me!', Icons.shuffle),
            _buildSearchSuggestion('Most Popular!', Icons.trending_up_rounded),
          ],
        ),
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

  Widget _buildSearchBar() {
    return TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'Search for a recipe..',
          labelStyle: const TextStyle(color: Colors.grey),
          suffixIcon: const Icon(Icons.search, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.lightBlue, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSubmitted: (String value) {}
    );
  }

  Widget _buildSearchSuggestion(String title, IconData icon) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
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
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}


