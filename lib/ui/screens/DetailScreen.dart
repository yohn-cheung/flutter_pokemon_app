import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/services/pokemon_provider.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Detailscreen extends StatefulWidget {
  const Detailscreen({super.key, required this.id});
  final int id;

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PokemonProvider>(
        context,
        listen: false,
      ).getPokemonDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final pokemon = provider.selectedPokemon;

    if (pokemon == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final String backgroundUrl =
        'https://images4.alphacoders.com/574/574726.jpg';

    final statEntries = {
      'HP': pokemon.stats?.hp,
      'Attack': pokemon.stats?.attack,
      'Defense': pokemon.stats?.defense,
      'Sp. Atk': pokemon.stats?.spAttack,
      'Sp. Def': pokemon.stats?.spDefense,
      'Speed': pokemon.stats?.speed,
    };

    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Replace this section in your build method
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background image
                  SizedBox.expand(
                    child: Image.network(backgroundUrl, fit: BoxFit.cover),
                  ),

                  // Overlay
                  SizedBox.expand(
                    child: Container(
                      color: pokemon.typeOne.color.withValues(alpha: 0.6),
                    ),
                  ),

                  // Centered avatar
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: pokemon.typeOne.color.withValues(
                      alpha: 0.6,
                    ),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        'https://img.pokemondb.net/artwork/${pokemon.name.toLowerCase()}.jpg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ShadTabs(
              value: 'description',
              // tabBarConstraints: const BoxConstraints(maxWidth: 400),
              // contentConstraints: const BoxConstraints(maxWidth: 400),
              tabs: [
                ShadTab(
                  value: 'description',
                  content: ShadCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          pokemon.description?.description ??
                              'No description available.',
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
                        SizedBox(height: 2),
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
                  child: const Text('Description'),
                ),
                ShadTab(
                  value: 'stats',
                  content: ShadCard(
                    child: Column(
                      children: [
                        ...statEntries.entries.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  entry.value.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Stats'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
