import 'package:equatable/equatable.dart';
import '../../../shared/models/simple_meal_model.dart';

abstract class MealsListState extends Equatable {
  const MealsListState();

  @override
  List<Object?> get props => [];
}

class MealsListInitial extends MealsListState {}

class MealsListLoading extends MealsListState {}

class MealsListLoaded extends MealsListState {
  final List<SimpleMeal> meals;
  final String title;

  const MealsListLoaded({
    required this.meals,
    required this.title,
  });

  @override
  List<Object?> get props => [meals, title];
}

class MealsListError extends MealsListState {
  final String message;

  const MealsListError(this.message);

  @override
  List<Object?> get props => [message];
}

