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

Set<Faction> convertFromFactionDataOrThrow(List<FactionData> data) {
  final identifiers = data.map((e) => e.id).toSet();
  final identifiersWeakness = data.map((e) => e.weaknessId).toSet();
  final identifiersStrength = data.map((e) => e.strengthId).toSet();

  final unknownIdentifiersWeakness =
      identifiersWeakness.where((id) => !identifiers.contains(id)).toSet();

  if (unknownIdentifiersWeakness.isNotEmpty) {
    throw Exception(
        "Invalid faction data: Unknown weaknessId: $unknownIdentifiersWeakness");
  }

  final unknownIdentifiersStrength =
      identifiersStrength.where((id) => !identifiers.contains(id)).toSet();

  if (unknownIdentifiersStrength.isNotEmpty) {
    throw Exception(
        "Invalid faction data: Unknown strengthId: $unknownIdentifiersWeakness");
  }

  final selfReferencing = data
      .where((faction) =>
          faction.id == faction.weaknessId || faction.id == faction.strengthId)
      .toSet();

  if (selfReferencing.isNotEmpty) {
    throw Exception(
        "Invalid faction data: Faction can't be self-reference for weakness or strength: $selfReferencing");
  }

  final factionIdMap = <FactionId, FactionData>{};
  for (var e in data) {
    factionIdMap[FactionId(id: e.id, name: e.name)] = e;
  }

  final factions = <Faction>{};
  factionIdMap.forEach((factionId, factionData) {
    factions.add(
      Faction(
        factionId: factionId,
        weakness: factionIdMap.entries
            .firstWhere((entry) => entry.value.id == factionData.weaknessId)
            .key,
        strength: factionIdMap.entries
            .firstWhere((entry) => entry.value.id == factionData.strengthId)
            .key,
      ),
    );
  });
  return factions;
}

class FactionData {
  final int id;
  final String name;
  final int weaknessId;
  final int strengthId;

  const FactionData({
    required this.id,
    required this.name,
    required this.weaknessId,
    required this.strengthId,
  });

  factory FactionData.fromMap(dynamic data) => FactionData(
      id: data['id'],
      name: data['name'],
      weaknessId: data['weakness'],
      strengthId: data['strength']);

  @override
  String toString() => '($id) $name';
}

class FactionId {
  const FactionId({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  String toString() => '($id) $name';
}

class Faction {
  const Faction({
    required this.factionId,
    required this.weakness,
    required this.strength,
  });

  final FactionId factionId;
  final FactionId weakness;
  final FactionId strength;

  int get id => factionId.id;

  String get name => factionId.name;

  @override
  String toString() => '$factionId (weakness=$weakness, strength=$strength)';
}
