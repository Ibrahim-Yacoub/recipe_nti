import 'package:equatable/equatable.dart';
import '../../../shared/models/meal_model.dart';
import '../../../shared/models/simple_meal_model.dart';
import '../../../shared/models/area_model.dart';
import '../../../shared/models/ingredient_item_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Meal> meals;
  final String searchQuery;

  const SearchLoaded({
    required this.meals,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [meals, searchQuery];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class FilterLoading extends SearchState {}

class FilterLoaded extends SearchState {
  final List<SimpleMeal> meals;
  final String filterType;
  final String filterValue;

  const FilterLoaded({
    required this.meals,
    required this.filterType,
    required this.filterValue,
  });

  @override
  List<Object?> get props => [meals, filterType, filterValue];
}

class AreasLoaded extends SearchState {
  final List<Area> areas;

  const AreasLoaded(this.areas);

  @override
  List<Object?> get props => [areas];
}

class IngredientsLoaded extends SearchState {
  final List<IngredientItem> ingredients;

  const IngredientsLoaded(this.ingredients);

  @override
  List<Object?> get props => [ingredients];
}

