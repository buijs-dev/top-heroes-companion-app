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

import '../../persistence/model/character_star.dart';

class Skill {
  final int id;
  final Set<int> characterIdList;
  final String name;
  final String description;

  /// The boost for each level associated by the index occurrence in the [description].
  ///
  /// A description may contain one or more boost types.
  /// Each type of boost has a variable amount which is increased by levelling up
  /// the skill.
  ///
  /// <b>Example</b>:<p>
  /// Given a description: "Increase direct damage by {}% and critical hit rate by {}%".
  ///
  /// Then [boostByLevel] should contain to lists of values, for example:
  /// </p>
  ///
  /// ```json
  /// {
  ///   1: 10,20,30,40,50,60,70,80,90,10,
  ///   2: 1.0, 1.2, 1.4, 1.8, 2.6, 3.0, 3.4, 3.8, 4.6, 5.4
  /// }
  /// ```
  ///
  /// And description could then be resolved depending on current level:<br/>
  /// At level 1: "Increase direct damage by 10% and critical hit rate by 1.0%". <br/>
  /// At level 2: "Increase direct damage by 20% and critical hit rate by 1.2%". <br/>
  final Map<int, List<double>> boostByLevel;
  final Set<SkillUpgrade> boostAdditional;

  const Skill({
    required this.id,
    required this.characterIdList,
    required this.name,
    required this.description,
    required this.boostByLevel,
    required this.boostAdditional,
  });

  factory Skill.fromMap(dynamic data) {
    final boost = data['boost'];
    final boostByLevel = <int, List<double>>{};
    boost['main'].forEach((d) {
      boostByLevel[d['part']] = [];
      final list = boostByLevel[d['part']]!;
      d['amount']?.forEach((d2) {
        final number = d2['number'];
        if (number != null) {
          list.add(number.toDouble());
        }
      });
    });

    final boostAdditional = boost['additional']
        .map(SkillUpgrade.fromMap)
        .whereType<SkillUpgrade>()
        .toSet();

    return Skill(
      id: data['id'],
      name: data['name'],
      characterIdList:
          data['heroes'].map((d) => d.toInt()).whereType<int>().toSet(),
      description: data['description'],
      boostByLevel: boostByLevel,
      boostAdditional: boostAdditional,
    );
  }

  Map<String, dynamic> get toJson {
    return {
      'id': id,
      'name': name,
      'description': description,
      'heroes': characterIdList,
      'boost': {
        'main': boostByLevel,
        'additional': boostAdditional.map((d) => d.toJson).toList()
      }
    };
  }

  @override
  String toString() =>
      'Skill(name=$name, description=$description, boostByLevel=$boostByLevel, boostByStar=$boostAdditional)';
}

class SkillUpgrade {
  final int? id;
  final int stars;
  final String description;
  final CharacterStar? unlockedAtStarType;
  final int? unlockedAtStarCount;

  const SkillUpgrade({
    required this.id,
    required this.description,
    required this.stars,
    required this.unlockedAtStarType,
    required this.unlockedAtStarCount,
  });

  Map<String, dynamic> get toJson => {
        'id': id,
        'description': description,
        'stars': stars,
        'unlocked': {
          'stars': unlockedAtStarCount,
          'type': unlockedAtStarType?.name
        }
      };

  factory SkillUpgrade.fromMap(dynamic data) {
    final unlockedAtStarType = switch (data['unlocked']?['type']) {
      "gold" => CharacterStar.gold,
      "red" => CharacterStar.red,
      "white" => CharacterStar.white,
      _ => null
    };
    return SkillUpgrade(
        id: data['id'],
        description: data['description'],
        stars: data['stars'],
        unlockedAtStarType: unlockedAtStarType,
        unlockedAtStarCount: data['unlocked']?['stars']);
  }
}
