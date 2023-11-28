import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models.dart/category.dart';
import 'package:mealsapp/models.dart/meal.dart';
import 'package:mealsapp/screens/meals.dart';
import 'package:mealsapp/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key, required this.toggleFavorites});
  void Function(Meal meal) toggleFavorites;
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((mealsss) => mealsss.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
            toggleFavorites: toggleFavorites,
            title: category.title,
            meals: filteredMeals))); //Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ]);
  }
}
