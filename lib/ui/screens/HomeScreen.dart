import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pokemon_app/models/Pokemon.dart';
import 'package:flutter_pokemon_app/services/pokemon_provider.dart';
import 'package:flutter_pokemon_app/ui/widgets/modal_dialog.dart';
import 'package:flutter_pokemon_app/ui/widgets/PokemonList.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Icon _customIcon = const Icon(Icons.search);
  Widget _customSearchBar = const Text('Pokemon');
  bool _initialized = false;

  final _textController = TextEditingController();

  void _setAppbar() {
    setState(() {
      if (_customIcon.icon == Icons.search) {
        _customIcon = const Icon(Icons.cancel);
        _customSearchBar = ListTile(
          leading: const Icon(Icons.search),
          title: TextField(
            controller: _textController,
            onSubmitted: (newValue) async {
              final provider = Provider.of<PokemonProvider>(
                context,
                listen: false,
              );

              // Call the provider method with filters
              await provider.getAllPokemonsWithFilters(
                regionId: null,
                typeId: null,
                search: newValue,
              );
            },
            decoration: InputDecoration(
              hintText: 'Search for pokemon..',
              hintStyle: const TextStyle(
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

        // Event to trigger when cancel is pressed:
        _textController.clear();

        // Optionally refresh or reset data
        final provider = Provider.of<PokemonProvider>(context, listen: false);
        provider.getAllPokemonsWithFilters(
          regionId: null,
          typeId: null,
          search: null,
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final provider = Provider.of<PokemonProvider>(context, listen: false);
      provider.getAllPokemons();
      provider.getAllTypes();
      provider.getAllRegion();
      _initialized = true;
    }
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
        child: Consumer<PokemonProvider>(
          builder: (context, provider, child) {
            List<Pokemon> pokemons = provider.pokemons;
            return Column(
              children: [Expanded(child: Pokemonlist(pokemons: pokemons))],
            );
          },
        ),
      ),
      floatingActionButton: ModalDialog(),
    );
  }
}
