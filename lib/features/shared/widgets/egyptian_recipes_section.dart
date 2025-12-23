import 'package:flutter/material.dart';
import '../models/simple_meal_model.dart';
import 'section_header.dart';
import 'egyptian_meal_card.dart';

class EgyptianRecipesSection extends StatelessWidget {
  final List<SimpleMeal> meals;
  final Function(String mealId) onMealTap;

  const EgyptianRecipesSection({
    super.key,
    required this.meals,
    required this.onMealTap,
  });

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: '🇪🇬 Egyptian Recipes',
          trailing: '${meals.length} dishes',
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return EgyptianMealCard(
                meal: meal,
                onTap: () => onMealTap(meal.idMeal),
              );
            },
          ),
        ),
      ],
    );
  }
}

