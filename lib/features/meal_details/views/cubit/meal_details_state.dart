import 'package:equatable/equatable.dart';
import '../../../shared/models/meal_model.dart';

abstract class MealDetailsState extends Equatable {
  const MealDetailsState();

  @override
  List<Object?> get props => [];
}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsLoaded extends MealDetailsState {
  final Meal meal;
  final bool isFavorite;

  const MealDetailsLoaded({
    required this.meal,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [meal, isFavorite];
}

class MealDetailsError extends MealDetailsState {
  final String message;

  const MealDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

