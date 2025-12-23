import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../shared/data/meal_repository.dart';
import '../../../shared/models/meal_model.dart';
import '../../../shared/models/meal_category_model.dart';
import '../../../shared/models/simple_meal_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MealRepository _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  List<MealCategory> _categories = [];
  Meal? _randomMeal;
  List<SimpleMeal> _egyptianMeals = [];

  Future<void> loadHomeData() async {
    try {
      emit(HomeLoading());

      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getRandomMeal(),
        _repository.filterByArea('Egyptian'),
      ]);

      _categories = results[0] as List<MealCategory>;
      _randomMeal = results[1] as Meal?;
      _egyptianMeals = results[2] as List<SimpleMeal>;

      emit(HomeLoaded(
        categories: _categories,
        randomMeal: _randomMeal,
        egyptianMeals: _egyptianMeals,
      ));
    } catch (e) {
      emit(HomeError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> refreshRandomMeal() async {
    try {
      emit(RandomMealLoading(
        categories: _categories,
        previousRandomMeal: _randomMeal,
        egyptianMeals: _egyptianMeals,
      ));

      _randomMeal = await _repository.getRandomMeal();

      emit(HomeLoaded(
        categories: _categories,
        randomMeal: _randomMeal,
        egyptianMeals: _egyptianMeals,
      ));
    } catch (e) {
      emit(HomeError(ApiErrorHandler.getMessage(e)));
    }
  }
}

