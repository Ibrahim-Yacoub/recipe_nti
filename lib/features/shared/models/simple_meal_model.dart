import 'package:equatable/equatable.dart';

class SimpleMeal extends Equatable {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  const SimpleMeal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory SimpleMeal.fromJson(Map<String, dynamic> json) {
    return SimpleMeal(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
    };
  }

  @override
  List<Object?> get props => [idMeal, strMeal, strMealThumb];
}

