import '../../../config/cache/cache_helper.dart';
import '../../../config/cache/cache_constants.dart';

class FavoritesManager {
  List<String> getFavoriteMealIds() {
    return CacheHelper.getStringList(CacheConstants.favoriteMeals) ?? [];
  }

  bool isFavorite(String mealId) {
    final favorites = getFavoriteMealIds();
    return favorites.contains(mealId);
  }

  Future<bool> addToFavorites(String mealId) async {
    final favorites = getFavoriteMealIds();
    if (!favorites.contains(mealId)) {
      favorites.add(mealId);
      return await CacheHelper.setStringList(
        CacheConstants.favoriteMeals,
        favorites,
      );
    }
    return false;
  }

  Future<bool> removeFromFavorites(String mealId) async {
    final favorites = getFavoriteMealIds();
    if (favorites.contains(mealId)) {
      favorites.remove(mealId);
      return await CacheHelper.setStringList(
        CacheConstants.favoriteMeals,
        favorites,
      );
    }
    return false;
  }

  Future<bool> toggleFavorite(String mealId) async {
    if (isFavorite(mealId)) {
      return await removeFromFavorites(mealId);
    } else {
      return await addToFavorites(mealId);
    }
  }

  Future<bool> clearFavorites() async {
    return await CacheHelper.remove(CacheConstants.favoriteMeals);
  }
}

