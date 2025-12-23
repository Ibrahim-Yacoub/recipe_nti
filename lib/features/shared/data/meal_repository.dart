import '../models/meal_model.dart';
import '../models/meal_category_model.dart';
import '../models/area_model.dart';
import '../models/ingredient_item_model.dart';
import '../models/simple_meal_model.dart';
import 'meal_web_service.dart';

class MealRepository {
  final MealWebService _webService;

  MealRepository(this._webService);

  Future<List<Meal>> searchMealByName(String name) async {
    return await _webService.searchMealByName(name);
  }

  Future<List<Meal>> searchByFirstLetter(String letter) async {
    return await _webService.searchByFirstLetter(letter);
  }

  Future<Meal?> getMealById(String id) async {
    return await _webService.getMealById(id);
  }

  Future<Meal?> getRandomMeal() async {
    return await _webService.getRandomMeal();
  }

  Future<List<MealCategory>> getCategories() async {
    return await _webService.getCategories();
  }

  Future<List<Area>> listAreas() async {
    return await _webService.listAreas();
  }

  Future<List<IngredientItem>> listIngredients() async {
    return await _webService.listIngredients();
  }

  Future<List<SimpleMeal>> filterByCategory(String category) async {
    return await _webService.filterByCategory(category);
  }

  Future<List<SimpleMeal>> filterByArea(String area) async {
    return await _webService.filterByArea(area);
  }

  Future<List<SimpleMeal>> filterByIngredient(String ingredient) async {
    return await _webService.filterByIngredient(ingredient);
  }
}

