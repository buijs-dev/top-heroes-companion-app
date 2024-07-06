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

import 'package:flutter/widgets.dart';
import 'package:top_heroes_companion_app/persistence/remote/character_database.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character_sorting.dart';

import '../../../persistence/persistence.dart';

class CharactersState extends ValueNotifier<Set<Character>> {
  Set<Character> data = CharactersDatabase.instance.characters;

  static final CharactersState _singleton = CharactersState._internal();

  factory CharactersState() {
    return _singleton;
  }

  CharactersState._internal() : super(CharactersDatabase.instance.characters);

  void filterByFaction(Map<Faction, bool> factionsToInclude) {
    filter((character) => factionsToInclude[character.faction] ?? true);
  }

  bool searchLogic(Character character, String query) {
    if (character.name.toLowerCase().contains(query)) {
      return true;
    } else if (character.faction.name.toLowerCase().contains(query)) {
      return true;
    } else if ("${character.id}".contains(query)) {
      return true;
    } else {
      return character.classes.any((attribute) {
        if (attribute.name.toLowerCase().contains(query)) {
          return true;
        }
        return attribute.description.toLowerCase().contains(query);
      });
    }
  }

  late List<Character> _dataMatchingSearchCriteria = [...data];
  late List<Character> _dataMatchingFilterCriteria = [...data];
  late List<Character> _dataMatchingSearchAndFilterCriteria = [...data];

  Set<Character> get dataMatchingSearchAndFilter =>
      _dataMatchingSearchAndFilterCriteria.toSet();

  void search(String query) {
    _dataMatchingSearchCriteria =
        data.where((d) => searchLogic(d, query)).toList();
    _dataMatchingSearchAndFilterCriteria = data.where((character) {
      return _dataMatchingFilterCriteria.contains(character) &&
          _dataMatchingSearchCriteria.contains(character);
    }).toList();
    value = _dataMatchingSearchAndFilterCriteria.toSet();
  }

  void filter(bool Function(Character) filter) {
    _dataMatchingFilterCriteria = data.where(filter).toList();
    _dataMatchingSearchAndFilterCriteria = data.where((character) {
      return _dataMatchingFilterCriteria.contains(character) &&
          _dataMatchingSearchCriteria.contains(character);
    }).toList();
    final newValue = _dataMatchingSearchAndFilterCriteria.toSet();
    value = newValue;
  }

  void sort(CharacterSortOrder order) {
    final sorted = <Character>[];
    switch (order) {
      case CharacterSortOrder.name:
        _dataMatchingSearchAndFilterCriteria
            .sort((a, b) => a.name.compareTo(b.name));
        value = _dataMatchingSearchAndFilterCriteria.toSet();
        break;

      case CharacterSortOrder.rarity:
        final charactersByRarity = <int, List<Character>>{
          1: [],
          2: [],
          3: [],
          4: []
        };

        for (final d in data) {
          charactersByRarity[d.rarity.id]?.add(d);
        }

        sorted.addAll(charactersByRarity[4]!);
        sorted.addAll(charactersByRarity[3]!);
        sorted.addAll(charactersByRarity[2]!);
        sorted.addAll(charactersByRarity[1]!);
        data = sorted.toSet();
        var sortedAndFiltered = sorted
            .where((d) => _dataMatchingSearchAndFilterCriteria.contains(d))
            .toList();
        _dataMatchingSearchAndFilterCriteria = sortedAndFiltered;
        value = _dataMatchingSearchAndFilterCriteria.toSet();
        break;

      case CharacterSortOrder.faction:
        final charactersByFaction = <int, List<Character>>{
          1: [],
          2: [],
          3: [],
        };

        for (final d in data) {
          charactersByFaction[d.faction.id]!.add(d);
        }

        for (var i = 1; i <= 3; i++) {
          sorted.addAll(charactersByFaction[i]!);
        }

        data = sorted.toSet();
        var sortedAndFiltered = sorted
            .where((d) => _dataMatchingSearchAndFilterCriteria.contains(d))
            .toList();
        _dataMatchingSearchAndFilterCriteria = sortedAndFiltered;
        value = _dataMatchingSearchAndFilterCriteria.toSet();
        break;
    }
  }
}
