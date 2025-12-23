import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/service_locator.dart';
import '../features/home/views/home_view.dart';
import '../features/search/views/search_view.dart';
import '../features/favorites/views/favorites_view.dart';
import '../features/home/views/cubit/home_cubit.dart';
import '../features/search/views/cubit/search_cubit.dart';
import '../features/favorites/views/cubit/favorites_cubit.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int _currentIndex = 0;

  late final HomeCubit _homeCubit;
  late final SearchCubit _searchCubit;
  late final FavoritesCubit _favoritesCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>()..loadHomeData();
    _searchCubit = getIt<SearchCubit>();
    _favoritesCubit = getIt<FavoritesCubit>()..loadFavorites();
  }

  @override
  void dispose() {
    _homeCubit.close();
    _searchCubit.close();
    _favoritesCubit.close();
    super.dispose();
  }

  List<Widget> get _screens => [
    BlocProvider.value(
      value: _homeCubit,
      child: const HomeView(),
    ),
    BlocProvider.value(
      value: _searchCubit,
      child: const SearchView(),
    ),
    BlocProvider.value(
      value: _favoritesCubit,
      child: const FavoritesView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 2) {
            _favoritesCubit.loadFavorites();
          }
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

