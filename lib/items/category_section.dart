import 'package:flutter/material.dart';
import 'package:recipes_app/items/category_item.dart';

class CategorySection extends StatelessWidget {
  final List<String> categories;
  final Function(String, int?) onCategorySelected;

  const CategorySection({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 140,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final imagePath = 'assets/images/${index + 1}.png';
            final categoryName = categories[index];

            return Padding(
              padding: const EdgeInsets.all(9.0),
              child: InkWell(
                onTap: () => onCategorySelected(categoryName, index),
                child: CategoryItem(
                  imagePath: imagePath,
                  categoryName: categoryName,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}