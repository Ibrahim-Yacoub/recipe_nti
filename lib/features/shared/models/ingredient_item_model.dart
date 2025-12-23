import 'package:equatable/equatable.dart';

class IngredientItem extends Equatable {
  final String idIngredient;
  final String strIngredient;
  final String? strDescription;

  const IngredientItem({
    required this.idIngredient,
    required this.strIngredient,
    this.strDescription,
  });

  factory IngredientItem.fromJson(Map<String, dynamic> json) {
    return IngredientItem(
      idIngredient: json['idIngredient'] ?? '',
      strIngredient: json['strIngredient'] ?? '',
      strDescription: json['strDescription'],
    );
  }

  String get imageUrl =>
      'https://www.themealdb.com/images/ingredients/${strIngredient.replaceAll(' ', '_')}.png';

  Map<String, dynamic> toJson() {
    return {
      'idIngredient': idIngredient,
      'strIngredient': strIngredient,
      'strDescription': strDescription,
    };
  }

  @override
  List<Object?> get props => [idIngredient, strIngredient, strDescription];
}

