import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../shared/data/meal_repository.dart';
import '../../../shared/data/favorites_manager.dart';
import '../../../shared/models/meal_model.dart';
import 'meal_details_state.dart';

class MealDetailsCubit extends Cubit<MealDetailsState> {
  final MealRepository _repository;
  final FavoritesManager _favoritesManager;

  MealDetailsCubit(this._repository, this._favoritesManager)
      : super(MealDetailsInitial());

  Meal? _currentMeal;

  Future<void> loadMealDetails(String mealId) async {
    try {
      emit(MealDetailsLoading());

      final meal = await _repository.getMealById(mealId);

      if (meal != null) {
        _currentMeal = meal;
        final isFavorite = _favoritesManager.isFavorite(mealId);
        emit(MealDetailsLoaded(meal: meal, isFavorite: isFavorite));
      } else {
        emit(const MealDetailsError('Meal not found'));
      }
    } catch (e) {
      emit(MealDetailsError(ApiErrorHandler.getMessage(e)));
    }
  }

  void loadFromMeal(Meal meal) {
    _currentMeal = meal;
    final isFavorite = _favoritesManager.isFavorite(meal.idMeal);
    emit(MealDetailsLoaded(meal: meal, isFavorite: isFavorite));
  }

  Future<void> toggleFavorite() async {
    if (_currentMeal == null) return;

    final currentState = state;
    if (currentState is MealDetailsLoaded) {
      await _favoritesManager.toggleFavorite(_currentMeal!.idMeal);
      final isFavorite = _favoritesManager.isFavorite(_currentMeal!.idMeal);
      emit(MealDetailsLoaded(meal: _currentMeal!, isFavorite: isFavorite));
    }
  }
}

