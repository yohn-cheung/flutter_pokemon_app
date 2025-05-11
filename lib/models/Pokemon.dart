import 'package:flutter_pokemon_app/models/PokemonType.dart';
import 'package:flutter_pokemon_app/models/Region.dart';
import 'package:flutter_pokemon_app/models/Description.dart';
import 'package:flutter_pokemon_app/models/Stats.dart';

class Pokemon {
  int id;
  int pokemonNationalIndex;
  String name;
  double height;
  double weight;
  PokemonType typeOne;
  PokemonType? typeTwo;
  Region? region;
  Description? description;
  Stats? stats;
  String? imageUrl; // Add this

  Pokemon({
    required this.id,
    required this.pokemonNationalIndex,
    required this.name,
    required this.height,
    required this.weight,
    required this.typeOne,
    this.typeTwo,
    this.region,
    this.description,
    this.stats,
    this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      // pokemonNationalIndex: json['pokemon_national_index'],
      pokemonNationalIndex: json['pokemon_national_index'],
      name: json['name'],
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      typeOne: PokemonType.fromJson(json['type_one']),
      typeTwo:
          json['type_two'] != null
              ? PokemonType.fromJson(json['type_two'])
              : null,

      // typeOne: Type.fromJson(json['typeOne']),
      // typeTwo: Type.fromJson(json['typeTwo']),
      region: Region.fromJson(json['region']),
    );
  }
}
