import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/models/Pokemon.dart';
import 'package:flutter_pokemon_app/models/PokemonType.dart';
import 'package:flutter_pokemon_app/models/Region.dart';
import 'package:flutter_pokemon_app/services/api.dart';

class PokemonProvider extends ChangeNotifier {
  late final apiService = ApiService();
  bool isLoading = false;

  List<Pokemon> pokemons = [];
  List<PokemonType> types = [];
  List<Region> regions = [];
  String url = '';
  // Pokemon? selectedPokemon;

  Pokemon? selectedPokemon;
  Future<void> getAllPokemons() async {
    try {
      pokemons = await apiService.fetchPokemons();
    } catch (e) {
      print('Failed to load pokemons: $e');
    }
    notifyListeners();
  }

  Future<void> getAllTypes() async {
    try {
      types = await apiService.fetchPokemonTypes();
    } catch (e) {
      print('Failed to load types: $e');
    }
    notifyListeners();
  }

  Future<void> getAllRegion() async {
    try {
      regions = await apiService.fetchRegions();
    } catch (e) {
      print('Failed to load regions: $e');
    }
    notifyListeners();
  }

  Future<void> getImage(imageUrl) async {
    try {
      url = await apiService.validateImage(imageUrl);
    } catch (e) {
      print('Failed to load image: $e');
    }
    notifyListeners();
  }

  Future<void> getPokemonDetails(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      selectedPokemon = await apiService.getPokemonDetails(id);
    } catch (e) {
      print('Failed to load pokemon details: $e');
      selectedPokemon = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllPokemonsWithFilters({
    int? regionId,
    int? typeId,
    String? search,
  }) async {
    try {
      pokemons = await apiService.fetchPokemons(
        regionId: regionId,
        typeId: typeId,
        search: search,
      );
    } catch (e) {
      print('Failed to load pokemons: $e');
    }
    notifyListeners();
  }
}
