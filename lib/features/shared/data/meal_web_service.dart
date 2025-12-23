import 'package:dio/dio.dart';
import '../../../core/networking/api_constants.dart';
import '../models/meal_model.dart';
import '../models/meal_category_model.dart';
import '../models/area_model.dart';
import '../models/ingredient_item_model.dart';
import '../models/simple_meal_model.dart';

class MealWebService {
  final Dio _dio;

  MealWebService(this._dio);

  Future<List<Meal>> searchMealByName(String name) async {
    try {
      final response = await _dio.get(
        ApiConstants.searchByName,
        queryParameters: {'s': name},
      );

      if (response.data['meals'] != null) {
        return (response.data['meals'] as List)
            .map((meal) => Meal.fromJson(meal))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Meal>> searchByFirstLetter(String letter) async {
    try {
      final response = await _dio.get(
        ApiConstants.searchByFirstLetter,
        queryParameters: {'f': letter},
      );

      if (response.data['meals'] != null) {
        return (response.data['meals'] as List)
            .map((meal) => Meal.fromJson(meal))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Meal?> getMealById(String id) async {
    try {
      final response = await _dio.get(
        ApiConstants.lookupById,
        queryParameters: {'i': id},
      );

      if (response.data['meals'] != null &&
          (response.data['meals'] as List).isNotEmpty) {
        return Meal.fromJson(response.data['meals'][0]);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<Meal?> getRandomMeal() async {
    try {
      final response = await _dio.get(ApiConstants.random);

      if (response.data['meals'] != null &&
          (response.data['meals'] as List).isNotEmpty) {
        return Meal.fromJson(response.data['meals'][0]);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MealCategory>> getCategories() async {
    try {
      final response = await _dio.get(ApiConstants.categories);

      if (response.data['categories'] != null) {
        return (response.data['categories'] as List)
            .map((category) => MealCategory.fromJson(category))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Area>> listAreas() async {
    try {
      final response = await _dio.get(
        ApiConstants.list,
        queryParameters: {'a': 'list'},
      );

      if (response.data['meals'] != null) {
        return (response.data['meals'] as List)
            .map((area) => Area.fromJson(area))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<IngredientItem>> listIngredients() async {
    try {
      final response = await _dio.get(
        ApiConstants.list,
        queryParameters: {'i': 'list'},
      );

      if (response.data['meals'] != null) {
        return (response.data['meals'] as List)
            .map((ingredient) => IngredientItem.fromJson(ingredient))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SimpleMeal>> filterByCategory(String category) async {
    try {
      final response = await _dio.get(
        ApiConstants.filter,
        queryParameters: {'c': category},
      );

      if (response.data['meals'] != null) {
        return (response.data['meals'] as List)
            .map((meal) => SimpleMeal.fromJson(meal))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SimpleMeal>> filterByArea(String area) async {
    try {
      final response = await _dio.get(
        ApiConstants.filter,
        queryParameters: {'a': area},
      );

      if (response.data['meals'] != null) {
        return (response.data['meals'] as List)
            .map((meal) => SimpleMeal.fromJson(meal))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SimpleMeal>> filterByIngredient(String ingredient) async {
    try {
      final response = await _dio.get(
        ApiConstants.filter,
        queryParameters: {'i': ingredient},
      );

      if (response.data['meals'] != null) {
        return (response.data['meals'] as List)
            .map((meal) => SimpleMeal.fromJson(meal))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}

