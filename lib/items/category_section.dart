import 'package:flutter/material.dart';
import 'package:recipes_app/items/category_item.dart';
import 'package:recipes_app/screens/category/category_detail_screen.dart';

class CategorySection extends StatelessWidget {
  final List<String> categories;
  final Function(String?) onCategorySelected;

  const CategorySection({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  onCategorySelected(categories[index]);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailScreen(categoryName: categories[index]),
                    ),
                  );
                },
                child: Semantics(
                  label: categories[index],
                  child: CategoryItem(
                    imagePath: 'assets/images/${index + 1}.png',
                    categoryName: categories[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
