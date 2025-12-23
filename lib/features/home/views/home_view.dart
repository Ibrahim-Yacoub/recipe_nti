import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/navigation_helper.dart';
import '../../shared/widgets/widgets.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Recipe NTI',
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const HomeSkeletonLoader();
          }

          if (state is HomeError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<HomeCubit>().loadHomeData(),
            );
          }

          if (state is HomeLoaded || state is RandomMealLoading) {
            final categories = state is HomeLoaded
                ? state.categories
                : (state as RandomMealLoading).categories;
            final randomMeal = state is HomeLoaded
                ? state.randomMeal
                : (state as RandomMealLoading).previousRandomMeal;
            final egyptianMeals = state is HomeLoaded
                ? state.egyptianMeals
                : (state as RandomMealLoading).egyptianMeals;
            final isRefreshing = state is RandomMealLoading;

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeCubit>().loadHomeData();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Categories',
                      trailing: '${categories.length} available',
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return CategoryCard(
                            categoryName: category.strCategory,
                            categoryThumb: category.strCategoryThumb,
                            onTap: () => NavigationHelper.navigateToMealsByCategory(
                              context,
                              category.strCategory,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    SectionHeader(
                      title: 'Random Meal',
                      action: IconButton(
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.deepOrange,
                        ),
                        onPressed: isRefreshing
                            ? null
                            : () {
                                context
                                    .read<HomeCubit>()
                                    .refreshRandomMeal();
                              },
                      ),
                    ),
                    if (randomMeal != null)
                      RandomMealCard(
                        meal: randomMeal,
                        isLoading: isRefreshing,
                        onTap: () => NavigationHelper.navigateToMealDetailsWithMeal(
                          context,
                          randomMeal,
                        ),
                      ),
                    const SizedBox(height: 24),
                    EgyptianRecipesSection(
                      meals: egyptianMeals,
                      onMealTap: (mealId) => NavigationHelper.navigateToMealDetails(
                        context,
                        mealId,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

