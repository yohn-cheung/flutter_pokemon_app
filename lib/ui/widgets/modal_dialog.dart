import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/ui/widgets/filter_bottom_sheet.dart';

class ModalDialog extends StatefulWidget {
  const ModalDialog({super.key});
  @override
  State<ModalDialog> createState() => _ModalDialogState();
}

class _ModalDialogState extends State<ModalDialog> {
  String? selectedType;
  String? selectedRegion;

  int? selectedTypeId;
  int? selectedRegionId;

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
            return FilterBottomSheet(
              selectedType: selectedType,
              selectedRegion: selectedRegion,
              selectedTypeId: selectedTypeId,
              selectedRegionId: selectedRegionId,
              onSelectionChanged: (type, region, typeId, regionId) {
                setState(() {
                  selectedType = type;
                  selectedRegion = region;
                  selectedTypeId = typeId;
                  selectedRegionId = regionId;
                });
              },
            );
          },
        );
      },
      child: const Icon(Icons.sort_sharp),
    );
  }
}
