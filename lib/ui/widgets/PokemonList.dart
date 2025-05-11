import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/models/Pokemon.dart';
import 'package:flutter_pokemon_app/services/api.dart';
import 'package:flutter_pokemon_app/ui/screens/DetailScreen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Pokemonlist extends StatefulWidget {
  const Pokemonlist({super.key, required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  State<Pokemonlist> createState() => _PokemonlistState();
}

class _PokemonlistState extends State<Pokemonlist> {
  @override
  void initState() {
    super.initState();
    preloadImages();
  }

  void preloadImages() async {
    for (var pokemon in widget.pokemons) {
      final url = await getImage(pokemon.name);
      setState(() {
        pokemon.imageUrl = url;
      });
    }
  }

  Future<String> getImage(String pokemonName) async {
    final url =
        'https://img.pokemondb.net/artwork/${pokemonName.toLowerCase()}.jpg';
    return await ApiService().validateImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: widget.pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        final pokemon = widget.pokemons[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Detailscreen()),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Row(
              children: [
                Image.network(
                  // 'https://picsum.photos/250?image=9',
                  // 'https://img.pokemondb.net/artwork/${pokemon.name.toLowerCase()}.jpg',
                  pokemon.imageUrl ?? 'https://picsum.photos/250?image=9',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  scale: 1.0,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text("No: ${pokemon.pokemonNationalIndex}"),
                          SizedBox(width: 100),
                          ShadBadge(
                            backgroundColor: pokemon.typeOne.color,
                            child: Text(
                              pokemon.typeOne.name,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          if (pokemon.typeTwo != null) ...[
                            SizedBox(width: 8),
                            ShadBadge(
                              backgroundColor: pokemon.typeTwo!.color,
                              child: Text(
                                pokemon.typeTwo!.name,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          Text('Height: ${pokemon.height} m'),
                          SizedBox(width: 40),
                          Text('Weight ${pokemon.height} kg'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
