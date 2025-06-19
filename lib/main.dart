import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_pokemon_app/services/pokemon_provider.dart';
import 'package:flutter_pokemon_app/ui/screens/HomeScreen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => PokemonProvider(),
      child: const ShadApp.material(home: Homescreen()),
    ),
  );
}
