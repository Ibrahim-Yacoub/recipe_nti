import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/navigation_helper.dart';
import '../../shared/widgets/widgets.dart';
import 'cubit/favorites_cubit.dart';
import 'cubit/favorites_state.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Favorites',
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const LoadingIndicator();
          }

          if (state is FavoritesError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<FavoritesCubit>().loadFavorites(),
            );
          }

          if (state is FavoritesEmpty) {
            return const EmptyStateWidget(
              icon: Icons.favorite_border,
              title: 'No favorites yet',
              subtitle: 'Start adding your favorite recipes!',
            );
          }

          if (state is FavoritesLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<FavoritesCubit>().loadFavorites();
              },
              child: MealGrid(
                childAspectRatio: 0.75,
                meals: state.favoriteMeals.map((meal) => MealGridItem(
                  mealId: meal.idMeal,
                  mealName: meal.strMeal,
                  mealThumb: meal.strMealThumb,
                  subtitle: meal.strCategory,
                  onTap: () async {
                    await NavigationHelper.navigateToMealDetailsWithMeal(
                      context,
                      meal,
                    );

                    if (context.mounted) {
                      context.read<FavoritesCubit>().loadFavorites();
                    }
                  },
                  trailing: FavoriteIconButton(
                    isFavorite: true,
                    onPressed: () {
                      context
                          .read<FavoritesCubit>()
                          .removeFromFavorites(meal.idMeal);
                    },
                  ),
                )).toList(),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

