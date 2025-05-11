import 'dart:convert';
import 'package:flutter_pokemon_app/models/Pokemon.dart';
import 'package:flutter_pokemon_app/models/PokemonType.dart';
import 'package:flutter_pokemon_app/models/Region.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final baseUrl = dotenv.env['URL'];

  Future<List<Pokemon>> fetchPokemons() async {
    final http.Response response = await http.get(
      Uri.parse('$baseUrl/v1/pokemons'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    final Map<String, dynamic> data = json.decode(response.body);

    if (!data.containsKey('data') || data['data'] is! List) {
      throw Exception('Failed to load pokemons');
    }
    List pokemons = data['data'];
    return pokemons.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }

  Future<List<PokemonType>> fetchPokemonTypes() async {
    final http.Response response = await http.get(
      Uri.parse('$baseUrl/v1/types'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    final Map<String, dynamic> data = json.decode(response.body);
    if (!data.containsKey('data') || data['data'] is! List) {
      throw Exception('Failed to load pokemon types');
    }

    List pokemonTypes = data['data'];
    return pokemonTypes
        .map((pokemonType) => PokemonType.fromJson(pokemonType))
        .toList();
  }

  Future<List<Region>> fetchRegions() async {
    final http.Response response = await http.get(
      Uri.parse('$baseUrl/v1/regions'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    final Map<String, dynamic> data = json.decode(response.body);
    if (!data.containsKey('data') || data['data'] is! List) {
      throw Exception('Failed to load pokemon regions');
    }

    List regions = data['data'];
    return regions.map((region) => Region.fromJson(region)).toList();
  }

  Future<String> validateImage(String imageUrl) async {
    try {
      final res = await http.get(Uri.parse(imageUrl));
      if (res.statusCode == 200) {
        return imageUrl;
      }
    } catch (_) {
      // Ignore errors, fall through to return placeholder
    }
    // return 'https://placehold.co/50x50';
    return 'https://picsum.photos/250?image=9';
  }
}
