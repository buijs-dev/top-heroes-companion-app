// Copyright (c) 2021 - 2024 Buijs Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:top_heroes_companion_app/persistence/remote/factions_database.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character_sorting.dart';
import 'package:top_heroes_companion_app/presentation/theme.dart';

import '../../../persistence/persistence.dart';
import '../../common/provider.dart';
import '../../common/string_utils.dart';
import 'characters_state.dart';

class CharacterFilter extends StatefulWidget {
  const CharacterFilter({super.key});

  @override
  State<CharacterFilter> createState() => _CharacterFilterState();
}

class _CharacterFilterState extends State<CharacterFilter> {
  final selection = <Faction, bool>{};

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CharactersState>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CharacterSorting(onChanged: (order) {
            state.sort(order);
          }),
          const SizedBox(height: 80),
          AutoSizeText(
            'Factions',
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Divider(color: Colors.black),
          ...FactionsDatabase.instance.factions.map(
            (faction) => ColoredBox(
              color: backgroundColor,
              child: Material(
                color: backgroundColor,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: AutoSizeText(faction.name.capitalized,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium),
                  value: selection[faction] ?? true,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onChanged: (bool? value) {
                    selection[faction] = !(selection[faction] ?? true);
                    state.filterByFaction(selection);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
