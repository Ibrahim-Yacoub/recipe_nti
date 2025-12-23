import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/navigation_helper.dart';
import '../../shared/widgets/widgets.dart';
import 'cubit/meals_list_cubit.dart';
import 'cubit/meals_list_state.dart';

class MealsListView extends StatelessWidget {
  const MealsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsListCubit, MealsListState>(
      builder: (context, state) {
        final title = state is MealsListLoaded ? state.title : 'Meals';
        return Scaffold(
          appBar: CustomAppBar(title: title),
          body: _buildBody(state, context),
        );
      },
    );
  }

  Widget _buildBody(MealsListState state, BuildContext context) {
    if (state is MealsListLoading) {
      return const LoadingIndicator();
    }

    if (state is MealsListError) {
      return ErrorStateWidget(message: state.message);
    }

    if (state is MealsListLoaded) {
      if (state.meals.isEmpty) {
        return const EmptyStateWidget(
          icon: Icons.restaurant,
          title: 'No meals found',
        );
      }

      return MealGrid(
        meals: state.meals.map((meal) => MealGridItem(
          mealId: meal.idMeal,
          mealName: meal.strMeal,
          mealThumb: meal.strMealThumb,
          onTap: () => NavigationHelper.navigateToMealDetails(
            context,
            meal.idMeal,
          ),
        )).toList(),
      );
    }

    return const SizedBox.shrink();
  }
}

