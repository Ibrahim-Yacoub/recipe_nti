import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String idMeal;
  final String strMeal;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<Ingredient> ingredients;
  final String? strSource;

  const Meal({
    required this.idMeal,
    required this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.ingredients = const [],
    this.strSource,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredientsList = [];

    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];

      if (ingredient != null &&
          ingredient.isNotEmpty &&
          ingredient != 'null' &&
          ingredient.trim().isNotEmpty) {
        ingredientsList.add(Ingredient(
          name: ingredient,
          measure: measure ?? '',
        ));
      }
    }

    return Meal(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'] ?? '',
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredientsList,
      strSource: json['strSource'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strTags': strTags,
      'strYoutube': strYoutube,
      'strSource': strSource,
    };

    for (int i = 0; i < ingredients.length; i++) {
      json['strIngredient${i + 1}'] = ingredients[i].name;
      json['strMeasure${i + 1}'] = ingredients[i].measure;
    }

    return json;
  }

  @override
  List<Object?> get props => [
        idMeal,
        strMeal,
        strCategory,
        strArea,
        strInstructions,
        strMealThumb,
        strTags,
        strYoutube,
        ingredients,
        strSource,
      ];
}

class Ingredient extends Equatable {
  final String name;
  final String measure;

  const Ingredient({
    required this.name,
    required this.measure,
  });

  String get imageUrl =>
      'https://www.themealdb.com/images/ingredients/${name.replaceAll(' ', '_')}.png';

  @override
  List<Object?> get props => [name, measure];
}

