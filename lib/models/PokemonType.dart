import 'package:flutter/material.dart';

class PokemonType {
  int id;
  String name;
  Color color;

  PokemonType({required this.id, required this.name, required this.color});

  static Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Add full opacity
    }
    return Color(int.parse(hex, radix: 16));
  }

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      id: json['id'],
      name: json['name'],
      color: hexToColor(json['color']),
    );
  }
}
