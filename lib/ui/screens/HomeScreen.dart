import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/models/Pokemon.dart';
import 'package:flutter_pokemon_app/services/api.dart';
import 'package:flutter_pokemon_app/ui/widgets/modal_dialog.dart';
import 'package:flutter_pokemon_app/ui/widgets/PokemonList.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final apiService = ApiService();
  late Future<List<Pokemon>> _futurePokemons;

  Icon _customIcon = const Icon(Icons.search);
  Widget _customSearchBar = const Text('Pokemon');

  void _setAppbar() {
    setState(() {
      if (_customIcon.icon == Icons.search) {
        _customIcon = const Icon(Icons.cancel);
        _customSearchBar = const ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Search for pokemon..',
              hintStyle: TextStyle(
                // color: Colors.white,
                fontSize: 18,
                // fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
          ),
        );
      } else {
        _customIcon = const Icon(Icons.search);
        _customSearchBar = const Text('Pokemon');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _futurePokemons = apiService.fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: _customSearchBar,
        actions: [
          // Dialogfilter(),
          IconButton(icon: _customIcon, onPressed: _setAppbar),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _futurePokemons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final pokemons = snapshot.data!;
              return Column(
                children: [Expanded(child: Pokemonlist(pokemons: pokemons))],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: ModalDialog(),
    );
  }
}
