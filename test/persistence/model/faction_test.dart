import 'package:flutter_test/flutter_test.dart';
import 'package:top_heroes_companion_app/persistence/persistence.dart';

void main() {
  const league =
      FactionData(id: 1, name: 'League', weaknessId: 3, strengthId: 2);
  const nature =
      FactionData(id: 2, name: 'Nature', weaknessId: 1, strengthId: 3);
  const horde = FactionData(id: 3, name: 'Horde', weaknessId: 2, strengthId: 1);

  test('Verify factionData can be converted to factionId', () {
    // given
    final data = [league, nature, horde];

    // when
    final factions = convertFromFactionDataOrThrow(data);

    // Verify that our counter has incremented.
    expect(factions.length, 3);
  });
}
