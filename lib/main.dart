import 'package:flutter/material.dart';
import 'core/service_locator.dart';
import 'config/router/app_router.dart';
import 'config/router/routes.dart';
import 'views/bottom_nav_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe NTI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: Routes.bottomNav,
      home: const BottomNavView(),
    );
  }
}

