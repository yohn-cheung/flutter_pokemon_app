import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/models/PokemonType.dart';
import 'package:flutter_pokemon_app/models/Region.dart';
import 'package:flutter_pokemon_app/services/pokemon_provider.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? selectedType;
  final String? selectedRegion;
  final int? selectedTypeId;
  final int? selectedRegionId;
  final Function(String?, String?, int?, int?) onSelectionChanged;

  const FilterBottomSheet({
    super.key,
    this.selectedType,
    this.selectedRegion,
    this.selectedTypeId,
    this.selectedRegionId,
    required this.onSelectionChanged,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int? selectedTypeId;
  int? selectedRegionId;

  String? selectedType;
  String? selectedRegion;

  @override
  void initState() {
    super.initState();
    // Initialize with the passed values
    selectedType = widget.selectedType;
    selectedRegion = widget.selectedRegion;
    selectedTypeId = widget.selectedTypeId;
    selectedRegionId = widget.selectedRegionId;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context, listen: false);

    final List<PokemonType> types = provider.types;
    final List<Region> regions = provider.regions;

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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 250,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedType,
                  hint: const Text("Select type"),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                      selectedTypeId =
                          types.firstWhere((type) => type.name == value).id;
                      widget.onSelectionChanged(
                        selectedType,
                        selectedRegion,
                        selectedTypeId,
                        selectedRegionId,
                      );
                    });
                  },
                  items:
                      types.map((type) {
                        return DropdownMenuItem<String>(
                          value: type.name,
                          child: Text(type.name),
                        );
                      }).toList(),
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: 250,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedRegion,
                  hint: const Text("Select region"),
                  onChanged: (value) {
                    setState(() {
                      selectedRegion = value;
                      selectedRegionId =
                          regions
                              .firstWhere((region) => region.name == value)
                              .id;

                      widget.onSelectionChanged(
                        selectedType,
                        selectedRegion,
                        selectedTypeId,
                        selectedRegionId,
                      );
                    });
                  },
                  items:
                      regions.map((region) {
                        return DropdownMenuItem<String>(
                          value: region.name,
                          child: Text(region.name),
                        );
                      }).toList(),
                ),
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                child: const Text('Remove filters'),
                onPressed: () async {
                  final provider = Provider.of<PokemonProvider>(
                    context,
                    listen: false,
                  );

                  // Call the provider method with filters
                  await provider.getAllPokemonsWithFilters(
                    regionId: null,
                    typeId: null,
                    search: '',
                  );

                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 4),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Start'),
                onPressed: () async {
                  final provider = Provider.of<PokemonProvider>(
                    context,
                    listen: false,
                  );

                  // Call the provider method with filters
                  await provider.getAllPokemonsWithFilters(
                    regionId: selectedRegionId,
                    typeId: selectedTypeId,
                    search: '',
                  );

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
