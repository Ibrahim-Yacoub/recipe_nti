import 'package:equatable/equatable.dart';

class Area extends Equatable {
  final String strArea;

  const Area({required this.strArea});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(strArea: json['strArea'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'strArea': strArea};
  }

  @override
  List<Object?> get props => [strArea];
}

