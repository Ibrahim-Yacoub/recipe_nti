import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../shared/data/meal_repository.dart';
import 'meals_list_state.dart';

class MealsListCubit extends Cubit<MealsListState> {
  final MealRepository _repository;

  MealsListCubit(this._repository) : super(MealsListInitial());

  Future<void> loadMealsByCategory(String category) async {
    try {
      emit(MealsListLoading());
      final meals = await _repository.filterByCategory(category);
      emit(MealsListLoaded(meals: meals, title: category));
    } catch (e) {
      emit(MealsListError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> loadMealsByArea(String area) async {
    try {
      emit(MealsListLoading());
      final meals = await _repository.filterByArea(area);
      emit(MealsListLoaded(meals: meals, title: '$area Cuisine'));
    } catch (e) {
      emit(MealsListError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> loadMealsByIngredient(String ingredient) async {
    try {
      emit(MealsListLoading());
      final meals = await _repository.filterByIngredient(ingredient);
      emit(MealsListLoaded(meals: meals, title: 'With $ingredient'));
    } catch (e) {
      emit(MealsListError(ApiErrorHandler.getMessage(e)));
    }
  }
}

