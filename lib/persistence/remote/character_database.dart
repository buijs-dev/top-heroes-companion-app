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

import "package:flutter/services.dart" as s;
import 'package:yaml/yaml.dart';

import '../../generated/assets.gen.dart';
import '../model/character.dart';
import '../model/character_class.dart';
import '../model/character_skill.dart';
import '../model/faction.dart';
import '../model/rarity.dart';

class CharactersDatabase {
  CharactersDatabase._();

  static CharactersDatabase? _instance;

  static CharactersDatabase get instance =>
      _instance ??= CharactersDatabase._();

  late final Set<Character> _characters;

  Set<Character> get characters => _characters;

  Future<bool> initialize(
    Set<Faction> factions,
    Set<Class> classes,
    Set<Rarity> rarities,
    Set<Skill> skills,
  ) async {
    final text =
        await s.rootBundle.loadString(const $AssetsDatabaseGen().characters);
    final yaml = loadYaml(text) as YamlMap;
    if (yaml.containsKey('characters')) {
      mapper(e) => Character.fromMap(e, factions, classes, rarities, skills);
      final List<Character> data =
          yaml['characters'].map(mapper).whereType<Character>().toList();
      data.sort((a, b) => a.name.compareTo(b.name));
      _characters = data.toSet();
      return _characters.isNotEmpty;
    }
    return false;
  }
}
