import 'package:equatable/equatable.dart';
import '../../../shared/models/meal_model.dart';
import '../../../shared/models/meal_category_model.dart';
import '../../../shared/models/simple_meal_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MealCategory> categories;
  final Meal? randomMeal;
  final List<SimpleMeal> egyptianMeals;

  const HomeLoaded({
    required this.categories,
    this.randomMeal,
    this.egyptianMeals = const [],
  });

  @override
  List<Object?> get props => [categories, randomMeal, egyptianMeals];
}
class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}
class RandomMealLoading extends HomeState {
  final List<MealCategory> categories;
  final Meal? previousRandomMeal;
  final List<SimpleMeal> egyptianMeals;

  const RandomMealLoading({
    required this.categories,
    this.previousRandomMeal,
    this.egyptianMeals = const [],
  });

  @override
  List<Object?> get props => [categories, previousRandomMeal, egyptianMeals];
}
