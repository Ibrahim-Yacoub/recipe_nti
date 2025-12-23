import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/navigation_helper.dart';
import '../../shared/widgets/widgets.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_state.dart';
import 'widgets/filter_bottom_sheet.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String value) {
    FocusScope.of(context).unfocus();
    if (value.isNotEmpty) {
      if (value.length == 1) {
        context.read<SearchCubit>().searchByFirstLetter(value);
      } else {
        context.read<SearchCubit>().searchMealByName(value);
      }
    }
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Recipes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            FilterOptionTile(
              icon: Icons.public,
              title: 'By Area',
              subtitle: 'Filter recipes by country or region',
              onTap: () {
                Navigator.pop(context);
                _openFilterSheet(context, FilterType.area);
              },
            ),
            FilterOptionTile(
              icon: Icons.category,
              title: 'By Category',
              subtitle: 'Filter recipes by food category',
              onTap: () {
                Navigator.pop(context);
                _openFilterSheet(context, FilterType.category);
              },
            ),
            FilterOptionTile(
              icon: Icons.restaurant,
              title: 'By Ingredient',
              subtitle: 'Filter recipes by main ingredient',
              onTap: () {
                Navigator.pop(context);
                _openFilterSheet(context, FilterType.ingredient);
              },
            ),
          ],
        ),
      ),
    );
  }


  void _openFilterSheet(BuildContext context, FilterType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => FilterBottomSheet(
        filterType: type,
        onSelected: (value) {
          final cubit = this.context.read<SearchCubit>();
          switch (type) {
            case FilterType.area:
              cubit.filterByArea(value);
              break;
            case FilterType.category:
              cubit.filterByCategory(value);
              break;
            case FilterType.ingredient:
              cubit.filterByIngredient(value);
              break;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Search Recipes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterOptions(context),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.filter_list),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or by first letter',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<SearchCubit>().resetSearch();
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.deepOrange, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {});
                if (value.isEmpty) {
                  context.read<SearchCubit>().resetSearch();
                }
              },
              onSubmitted: _performSearch,
            ),
          ),
          
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const EmptyStateWidget(
                    icon: Icons.search,
                    title: 'Search for delicious recipes',
                    subtitle: 'Try searching by name, or use the filter button\nto browse by area, category, or ingredient',
                  );
                }

                if (state is SearchLoading || state is FilterLoading) {
                  return const LoadingIndicator();
                }

                if (state is SearchError) {
                  return ErrorStateWidget(message: state.message);
                }

                if (state is SearchLoaded) {
                  if (state.meals.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.search_off,
                      title: 'No recipes found',
                      subtitle: 'Try a different search term',
                    );
                  }
                  return _buildMealsList(context, state.meals);
                }

                if (state is FilterLoaded) {
                  if (state.meals.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.search_off,
                      title: 'No recipes found',
                      subtitle: 'Try a different search term',
                    );
                  }
                  return _buildMealsList(context, state.meals);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsList(BuildContext context, List<dynamic> meals) {
    return MealGrid(
      meals: meals.map((meal) => MealGridItem(
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
}
