import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../shared/data/meal_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MealRepository _repository;

  SearchCubit(this._repository) : super(SearchInitial());

  Future<void> searchMealByName(String name) async {
    if (name.isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      emit(SearchLoading());
      final meals = await _repository.searchMealByName(name);
      emit(SearchLoaded(meals: meals, searchQuery: name));
    } catch (e) {
      emit(SearchError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> searchByFirstLetter(String letter) async {
    if (letter.isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      emit(SearchLoading());
      final meals = await _repository.searchByFirstLetter(letter);
      emit(SearchLoaded(meals: meals, searchQuery: letter));
    } catch (e) {
      emit(SearchError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> filterByArea(String area) async {
    try {
      emit(FilterLoading());
      final meals = await _repository.filterByArea(area);
      emit(FilterLoaded(
        meals: meals,
        filterType: 'area',
        filterValue: area,
      ));
    } catch (e) {
      emit(SearchError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> filterByCategory(String category) async {
    try {
      emit(FilterLoading());
      final meals = await _repository.filterByCategory(category);
      emit(FilterLoaded(
        meals: meals,
        filterType: 'category',
        filterValue: category,
      ));
    } catch (e) {
      emit(SearchError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> filterByIngredient(String ingredient) async {
    try {
      emit(FilterLoading());
      final meals = await _repository.filterByIngredient(ingredient);
      emit(FilterLoaded(
        meals: meals,
        filterType: 'ingredient',
        filterValue: ingredient,
      ));
    } catch (e) {
      emit(SearchError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> loadAreas() async {
    try {
      emit(SearchLoading());
      final areas = await _repository.listAreas();
      emit(AreasLoaded(areas));
    } catch (e) {
      emit(SearchError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> loadIngredients() async {
    try {
      emit(SearchLoading());
      final ingredients = await _repository.listIngredients();
      emit(IngredientsLoaded(ingredients));
    } catch (e) {
      emit(SearchError(ApiErrorHandler.getMessage(e)));
    }
  }

  void resetSearch() {
    emit(SearchInitial());
  }
}

