import 'package:flutter/material.dart';
import 'package:recipes_app/screens/home_screen.dart';
import 'package:recipes_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
  title: 'Baking App',
  theme: ThemeData(
    primarySwatch: Colors.pink,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  initialRoute: '/login',
  routes: {
    '/login': (context) => const LoginScreen(),
    '/home': (context) => const HomeScreen(),
  },
);
  }
}
