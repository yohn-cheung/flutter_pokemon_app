import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/ui/screens/HomeScreen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ShadApp.material(home: Homescreen()));
}
