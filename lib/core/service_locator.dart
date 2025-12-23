import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../config/cache/cache_helper.dart';
import '../core/networking/dio_factory.dart';
import '../features/shared/data/meal_web_service.dart';
import '../features/shared/data/meal_repository.dart';
import '../features/shared/data/favorites_manager.dart';
import '../features/home/views/cubit/home_cubit.dart';
import '../features/search/views/cubit/search_cubit.dart';
import '../features/favorites/views/cubit/favorites_cubit.dart';
import '../features/meal_details/views/cubit/meal_details_cubit.dart';
import '../features/meals_list/views/cubit/meals_list_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {

  await CacheHelper.init();

  Dio dio = DioFactory.getDio();
  getIt.registerSingleton<Dio>(dio);

  getIt.registerSingleton<MealWebService>(MealWebService(getIt<Dio>()));

  getIt.registerSingleton<MealRepository>(
    MealRepository(getIt<MealWebService>()),
  );

  getIt.registerSingleton<FavoritesManager>(FavoritesManager());

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<MealRepository>()),
  );

  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(getIt<MealRepository>()),
  );

  getIt.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(
      getIt<MealRepository>(),
      getIt<FavoritesManager>(),
    ),
  );

  getIt.registerFactory<MealDetailsCubit>(
    () => MealDetailsCubit(
      getIt<MealRepository>(),
      getIt<FavoritesManager>(),
    ),
  );

  getIt.registerFactory<MealsListCubit>(
    () => MealsListCubit(getIt<MealRepository>()),
  );
}

