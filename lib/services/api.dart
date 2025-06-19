import 'dart:convert';
import 'package:flutter_pokemon_app/models/Pokemon.dart';
import 'package:flutter_pokemon_app/models/PokemonType.dart';
import 'package:flutter_pokemon_app/models/Region.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  // final baseUrl = dotenv.env['URL'];
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Pokemon>> fetchPokemons({
    int? regionId,
    int? typeId,
    String? search,
  }) async {
    Map<String, String> queryParams = {};

    if (regionId != null) {
      queryParams['region'] = regionId.toString();
    }
    if (typeId != null) {
      queryParams['type'] = typeId.toString();
    }

    if (search != null) {
      queryParams['search'] = search;
    }

    final Uri uri = Uri.http(
      '127.0.0.1:8000', // e.g. 'api.example.com'
      '/api/v1/pokemons',
      queryParams,
    );

    final http.Response response = await http.get(
      uri,
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
    // return 'https://picsum.photos/250?image=9';
    return 'https://placehold.co/400';
  }

  Future<Pokemon> getPokemonDetails(int id) async {
    final http.Response response = await http.get(
      Uri.parse('$baseUrl/v1/pokemons/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (json['data'] == null) throw Exception("API response missing 'data'");

    return Pokemon.fromJson(json['data']);
  }
}
