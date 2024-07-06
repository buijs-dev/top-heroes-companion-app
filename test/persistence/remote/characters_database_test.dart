import 'package:flutter_test/flutter_test.dart';
import 'package:top_heroes_companion_app/persistence/remote/character_database.dart';
import 'package:top_heroes_companion_app/persistence/repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Verify repository is loaded correctly', () async {
    await initializeRepository();
    final repository = CharactersDatabase.instance;
    expect(repository.characters.isNotEmpty, true);
    final hero = repository.characters.first;
    expect(hero.name, 'Adjudicator');
    expect(hero.id, 28);
    expect(hero.faction.name, 'League');
  });
}
