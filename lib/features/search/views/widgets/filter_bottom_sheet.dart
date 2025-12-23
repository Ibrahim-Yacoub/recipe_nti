import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service_locator.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

enum FilterType { area, category, ingredient }

class FilterBottomSheet extends StatelessWidget {
  final FilterType filterType;
  final Function(String) onSelected;

  const FilterBottomSheet({
    super.key,
    required this.filterType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<SearchCubit>();
        if (filterType == FilterType.area) {
          cubit.loadAreas();
        } else if (filterType == FilterType.ingredient) {
          cubit.loadIngredients();
        }
        return cubit;
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter by ${_getTitle()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    );
                  }

                  if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }

                  if (filterType == FilterType.category) {
                    return _buildCategoryList(context);
                  }

                  if (state is AreasLoaded) {
                    return _buildAreasList(context, state.areas);
                  }

                  if (state is IngredientsLoaded) {
                    final limitedIngredients = state.ingredients.take(50).toList();
                    return _buildIngredientsList(context, limitedIngredients);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    switch (filterType) {
      case FilterType.area:
        return 'Area';
      case FilterType.category:
        return 'Category';
      case FilterType.ingredient:
        return 'Ingredient';
    }
  }

  Widget _buildCategoryList(BuildContext context) {
    final categories = [
      'Beef',
      'Chicken',
      'Dessert',
      'Lamb',
      'Miscellaneous',
      'Pasta',
      'Pork',
      'Seafood',
      'Side',
      'Starter',
      'Vegan',
      'Vegetarian',
      'Breakfast',
      'Goat'
    ];

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(categories[index]),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.pop(context);
            onSelected(categories[index]);
          },
        );
      },
    );
  }

  Widget _buildAreasList(BuildContext context, areas) {
    return ListView.builder(
      itemCount: areas.length,
      itemBuilder: (context, index) {
        final area = areas[index];
        return ListTile(
          leading: const Icon(Icons.public, color: Colors.deepOrange),
          title: Text(area.strArea),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.pop(context);
            onSelected(area.strArea);
          },
        );
      },
    );
  }

  Widget _buildIngredientsList(BuildContext context, ingredients) {
    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return ListTile(
          leading: const Icon(Icons.restaurant, color: Colors.deepOrange),
          title: Text(ingredient.strIngredient),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.pop(context);
            onSelected(ingredient.strIngredient);
          },
        );
      },
    );
  }
}

