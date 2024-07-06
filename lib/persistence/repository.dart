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

import 'dart:async';

import 'package:top_heroes_companion_app/persistence/remote/skills_database.dart';

import 'local/character_skill_cache.dart';
import 'model/character.dart';
import 'model/character_class.dart';
import 'model/character_skill.dart';
import 'model/faction.dart';
import 'model/rarity.dart';
import 'remote/character_database.dart';
import 'remote/classes_database.dart';
import 'remote/factions_database.dart';
import 'remote/rarity_database.dart';

class TopHeroesRepository {
  final Set<Character> characters;
  final Set<Faction> factions;
  final Set<Rarity> rarities;
  final Set<Class> classes;
  final Set<Skill> skills;
  final CharacterSkillCache characterSkillCache;

  const TopHeroesRepository({
    required this.characters,
    required this.factions,
    required this.rarities,
    required this.classes,
    required this.skills,
    required this.characterSkillCache,
  });
}

Future<TopHeroesRepository?> initializeRepository() async {
  final List<bool> futures = await Future.wait([
    RarityDatabase.instance.initialize,
    ClassesDatabase.instance.initialize,
    FactionsDatabase.instance.initialize,
    SkillsDatabase.instance.initialize
  ]);

  if (futures.contains(false)) {
    return null;
  }

  final isOk = await CharactersDatabase.instance.initialize(
      FactionsDatabase.instance.factions,
      ClassesDatabase.instance.classes,
      RarityDatabase.instance.rarities,
      SkillsDatabase.instance.skills);

  if (!isOk) {
    return null;
  }

  final characterSkillCache = CharacterSkillCache.instance;
  final isInitialized = characterSkillCache.initialize();

  if (!isInitialized) {
    return null;
  }

  return TopHeroesRepository(
    characters: CharactersDatabase.instance.characters,
    factions: FactionsDatabase.instance.factions,
    classes: ClassesDatabase.instance.classes,
    rarities: RarityDatabase.instance.rarities,
    skills: SkillsDatabase.instance.skills,
    characterSkillCache: characterSkillCache,
  );
}
