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
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:top_heroes_companion_app/persistence/persistence.dart';

import '../model/character.dart';
import '../model/character_skill.dart';
import 'character_skill_cache_entry.dart';

class CharacterSkillCache {
  final _storage = GetStorage('TopHeroesCompanionApp');
  final Map<int, CharacterSkillCacheEntry> _cached = {};

  CharacterSkillCache._();

  static CharacterSkillCache? _instance;

  static CharacterSkillCache get instance =>
      _instance ??= CharacterSkillCache._();

  late final Set<Skill> _skills;

  Set<Skill> get skills => _skills;

  void put(Character character, Skill skill) {
    if (_cached[character.id] == null) {
      _cached[character.id] = CharacterSkillCacheEntry(character.id, {});
    }

    _cached[character.id]!.skills.add(skill);
    final data = _cached.values.map((d) => d.toJson).toList();
    final json = jsonEncode(data);
    _storage.write('skills', json);
  }

  Set<Skill> get(Character character) {
    return _cached[character.id]?.skills ?? {};
  }

  bool initialize() {
    final json = _storage.read<String>('skills');
    if (json == null) {
      _skills = {};
      return true;
    }

    _skills = {};
    return true;
  }
}
