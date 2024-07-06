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

import 'character_class.dart';
import 'character_skill.dart';
import 'character_skin.dart';
import 'faction.dart';
import 'rarity.dart';

class Character {
  final int id;
  final String name;
  final Rarity rarity;
  final Faction faction;
  final Set<Class> classes;
  final Set<Skin> skins;
  final Set<Skill> skills;

  const Character({
    required this.id,
    required this.name,
    required this.rarity,
    required this.faction,
    required this.classes,
    required this.skins,
    required this.skills,
  });

  factory Character.fromMap(dynamic data, Set<Faction> factions,
      Set<Class> classes, Set<Rarity> rarities, Set<Skill> skills) {
    final factionId = data['faction'];
    final classesData = data['classes'];
    final rarityId = data['rarity'];
    final List skinsList = data['skin'] ?? [];
    final Set<Skin> skins = skinsList.map((e) => Skin.fromMap(e)).toSet();
    final characterId = data['id'];
    return Character(
      id: characterId,
      name: data['name'],
      rarity: rarities.firstWhere((rarity) => rarity.id == rarityId),
      faction:
          factions.firstWhere((faction) => faction.factionId.id == factionId),
      classes: classes.where((clazz) => classesData.contains(clazz.id)).toSet(),
      skins: skins,
      skills: skills
          .where((skill) => skill.characterIdList.contains(characterId))
          .toSet(),
    );
  }

  @override
  String toString() => "Character $name";
}
