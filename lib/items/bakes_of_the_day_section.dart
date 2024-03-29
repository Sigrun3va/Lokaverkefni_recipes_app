import 'package:flutter/material.dart';
import 'package:recipes_app/screens/category/recipe_detail_screen.dart';
import 'package:recipes_app/model/recipe_model.dart';


class BakesOfTheDaySection extends StatelessWidget {
  final List<RecipeModel> bakesOfTheDay;

  const BakesOfTheDaySection({
    super.key,
    required this.bakesOfTheDay,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 65.0, 16.0, 15.0),
            child: Text(
              'Bakes of the day!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bakesOfTheDay.length,
              itemBuilder: (context, index) {
                final bake = bakesOfTheDay[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsScreen(recipe: bake),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.black,
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: 150,
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/comingsoon.jpg', // Placeholder image
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            bake.name,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
        ],
      ),
    );
  }
}