import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String categoryName;

  const CategoryItem({
    Key? key,
    required this.imagePath,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0),
      child: Column(
        children: <Widget>[
          Semantics(
            label: categoryName,
            child: Image.asset(imagePath, width: 105, height: 105),
          ),
          const SizedBox(height: 10),
          Text(
            categoryName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}