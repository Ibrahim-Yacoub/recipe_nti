import 'package:flutter/material.dart';
import 'meal_card.dart';

class MealGrid extends StatelessWidget {
  final List<MealGridItem> meals;
  final double childAspectRatio;

  const MealGrid({
    super.key,
    required this.meals,
    this.childAspectRatio = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return MealCard(
          mealId: meal.mealId,
          mealName: meal.mealName,
          mealThumb: meal.mealThumb,
          subtitle: meal.subtitle,
          onTap: meal.onTap,
          trailing: meal.trailing,
        );
      },
    );
  }
}

class MealGridItem {
  final String mealId;
  final String mealName;
  final String mealThumb;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  MealGridItem({
    required this.mealId,
    required this.mealName,
    required this.mealThumb,
    this.subtitle,
    required this.onTap,
    this.trailing,
  });
}

