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
import '../model/model.dart';

class SkillsDatabase {
  SkillsDatabase._();

  static SkillsDatabase? _instance;

  static SkillsDatabase get instance => _instance ??= SkillsDatabase._();

  late final Set<Skill> _skills;

  Set<Skill> get skills => _skills;

  Future<bool> get initialize async {
    final data =
        await s.rootBundle.loadString(const $AssetsDatabaseGen().skills);
    final mapData = loadYaml(data);
    final skills = mapData['skills']
        .whereType<YamlMap>()
        .map(Skill.fromMap)
        .whereType<Skill>()
        .toSet();
    _skills = skills;
    return _skills.isNotEmpty;
  }
}
