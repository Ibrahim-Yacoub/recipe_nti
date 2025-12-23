import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/service_locator.dart';
import '../../views/bottom_nav_view.dart';
import '../../features/meal_details/views/meal_details_view.dart';
import '../../features/meal_details/views/cubit/meal_details_cubit.dart';
import '../../features/meals_list/views/meals_list_view.dart';
import '../../features/meals_list/views/cubit/meals_list_cubit.dart';
import 'routes.dart';
import 'router_transitions.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.bottomNav:
        return MaterialPageRoute(
          builder: (_) => const BottomNavView(),
        );

      case Routes.mealDetails:
        final mealId = settings.arguments as String;
        return RouterTransitions.slideFromRight(
          BlocProvider(
            create: (context) => getIt<MealDetailsCubit>()
              ..loadMealDetails(mealId),
            child: const MealDetailsView(),
          ),
        );

      case Routes.mealsList:
        final args = settings.arguments as Map<String, dynamic>;
        final String type = args['type'];
        final String value = args['value'];

        return RouterTransitions.slideFromRight(
          BlocProvider(
            create: (context) {
              final cubit = getIt<MealsListCubit>();
              if (type == 'category') {
                cubit.loadMealsByCategory(value);
              } else if (type == 'area') {
                cubit.loadMealsByArea(value);
              } else if (type == 'ingredient') {
                cubit.loadMealsByIngredient(value);
              }
              return cubit;
            },
            child: const MealsListView(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const BottomNavView(),
        );
    }
  }
}

