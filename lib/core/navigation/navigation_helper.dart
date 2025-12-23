import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service_locator.dart';
import '../../features/meal_details/views/meal_details_view.dart';
import '../../features/meal_details/views/cubit/meal_details_cubit.dart';
import '../../features/meals_list/views/meals_list_view.dart';
import '../../features/meals_list/views/cubit/meals_list_cubit.dart';
import '../../features/shared/models/meal_model.dart';

class NavigationHelper {
  static Future<void> navigateToMealDetails(
    BuildContext context,
    String mealId,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<MealDetailsCubit>()
            ..loadMealDetails(mealId),
          child: const MealDetailsView(),
        ),
      ),
    );
  }

  static Future<void> navigateToMealDetailsWithMeal(
    BuildContext context,
    Meal meal,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<MealDetailsCubit>()
            ..loadFromMeal(meal),
          child: const MealDetailsView(),
        ),
      ),
    );
  }

  static Future<void> navigateToMealsByCategory(
    BuildContext context,
    String category,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<MealsListCubit>()
            ..loadMealsByCategory(category),
          child: const MealsListView(),
        ),
      ),
    );
  }

  static Future<void> navigateToMealsByArea(
    BuildContext context,
    String area,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<MealsListCubit>()
            ..loadMealsByArea(area),
          child: const MealsListView(),
        ),
      ),
    );
  }

  static Future<void> navigateToMealsByIngredient(
    BuildContext context,
    String ingredient,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<MealsListCubit>()
            ..loadMealsByIngredient(ingredient),
          child: const MealsListView(),
        ),
      ),
    );
  }
}

