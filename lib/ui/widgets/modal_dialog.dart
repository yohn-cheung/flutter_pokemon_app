import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/models/PokemonType.dart';
import 'package:flutter_pokemon_app/models/Region.dart';
import 'package:flutter_pokemon_app/services/api.dart';

class ModalDialog extends StatefulWidget {
  const ModalDialog({super.key});

  @override
  State<ModalDialog> createState() => _ModalDialogState();
}

class _ModalDialogState extends State<ModalDialog> {
  final apiService = ApiService();
  late Future<List<PokemonType>> _futurePokemonTypes;
  late Future<List<Region>> _futureRegions;

  int? selectedTypeId;
  int? selectedRegionId;

  @override
  void initState() {
    super.initState();
    _futurePokemonTypes = apiService.fetchPokemonTypes();
    _futureRegions = apiService.fetchRegions();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Filter on region or type',
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 310,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Filter type of region',
                      style: TextStyle(
                        fontSize: 16, // Increase font size
                        fontWeight: FontWeight.bold, // Make text bold
                      ),
                    ),
                    FutureBuilder(
                      future: _futurePokemonTypes,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final types = snapshot.data!;
                          return Container(
                            width: 250,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: selectedTypeId?.toString(),
                                hint: const Text("Select type"),
                                onChanged: (value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    selectedTypeId = int.tryParse(value ?? '');
                                    print(selectedTypeId);
                                  });
                                },
                                items:
                                    types.map((type) {
                                      return DropdownMenuItem<String>(
                                        value: type.id.toString(),
                                        child: Text(type.name),
                                      );
                                    }).toList(),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return const CircularProgressIndicator();
                      },
                    ),
                    FutureBuilder(
                      future: _futureRegions,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final regions = snapshot.data!;
                          return Container(
                            width: 250,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: selectedRegionId?.toString(),
                                hint: const Text("Select region"),
                                onChanged: (value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    selectedRegionId = int.tryParse(
                                      value ?? '',
                                    );
                                    print(selectedRegionId);
                                  });
                                },
                                items:
                                    regions.map((region) {
                                      return DropdownMenuItem<String>(
                                        value: region.id.toString(),
                                        child: Text(region.name),
                                      );
                                    }).toList(),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return const CircularProgressIndicator();
                      },
                    ),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(200, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text('Start'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.sort_sharp),
    );
  }
}
