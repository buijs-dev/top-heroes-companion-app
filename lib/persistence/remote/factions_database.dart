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
import '../model/faction.dart';

class FactionsDatabase {
  FactionsDatabase._();

  static FactionsDatabase? _instance;

  static FactionsDatabase get instance => _instance ??= FactionsDatabase._();

  late final Set<Faction> _factions;

  Set<Faction> get factions => _factions;

  Future<bool> get initialize async {
    final data =
        await s.rootBundle.loadString(const $AssetsDatabaseGen().factions);
    final mapData = loadYaml(data);
    final factionData = mapData['factions']
        .whereType<YamlMap>()
        .map(FactionData.fromMap)
        .whereType<FactionData>()
        .toList();
    _factions = convertFromFactionDataOrThrow(factionData);
    return _factions.isNotEmpty;
  }
}
