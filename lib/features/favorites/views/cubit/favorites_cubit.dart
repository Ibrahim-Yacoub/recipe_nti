import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../shared/data/meal_repository.dart';
import '../../../shared/data/favorites_manager.dart';
import '../../../shared/models/meal_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final MealRepository _repository;
  final FavoritesManager _favoritesManager;

  FavoritesCubit(this._repository, this._favoritesManager)
      : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    try {
      emit(FavoritesLoading());

      final favoriteIds = _favoritesManager.getFavoriteMealIds();

      if (favoriteIds.isEmpty) {
        emit(FavoritesEmpty());
        return;
      }

      final List<Meal> meals = [];
      for (String id in favoriteIds) {
        try {
          final meal = await _repository.getMealById(id);
          if (meal != null) {
            meals.add(meal);
          }
        } catch (e) {
          continue;
        }
      }

      if (meals.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(meals));
      }
    } catch (e) {
      emit(FavoritesError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> removeFromFavorites(String mealId) async {
    try {
      await _favoritesManager.removeFromFavorites(mealId);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(ApiErrorHandler.getMessage(e)));
    }
  }
}

