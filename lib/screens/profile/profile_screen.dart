import 'package:flutter/material.dart';
import 'package:recipes_app/screens/home_screen.dart';
import 'package:recipes_app/screens/search/search_screen.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({Key? key}) : super(key: key);

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
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildUserProfile(),
            const SizedBox(height: 20),
            _buildUserSections(context),
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

  Widget _buildUserProfile() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/images/comingsoon.jpg'),
        ),
        SizedBox(width: 20),
        Text(
          'Username',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildUserSections(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSection(context, 'My recipes', Icons.book),
        _buildSection(context, 'Loved', Icons.favorite),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF181818),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
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