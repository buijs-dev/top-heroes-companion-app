import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:top_heroes_companion_app/presentation/common/string_utils.dart';

enum CharacterSortOrder { name, rarity, faction }

class CharacterSorting extends StatefulWidget {
  const CharacterSorting({
    required this.onChanged,
    super.key,
  });

  final Function(CharacterSortOrder) onChanged;

  @override
  State<CharacterSorting> createState() => _CharacterSortingState();
}

class _CharacterSortingState extends State<CharacterSorting> {
  List<CharacterSortOrder> items = CharacterSortOrder.values;
  CharacterSortOrder dropdownValue = CharacterSortOrder.values.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          'Sort by ',
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        DropdownButton<CharacterSortOrder>(
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((CharacterSortOrder items) {
            return DropdownMenuItem<CharacterSortOrder>(
              value: items,
              child: Text(items.name.capitalized),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (CharacterSortOrder? newValue) {
            setState(() {
              widget.onChanged(newValue!);
              dropdownValue = newValue;
            });
          },
        ),
      ],
    );
  }
}
