import 'package:flutter_test/flutter_test.dart';
import 'package:top_heroes_companion_app/persistence/model/character_skill.dart';
import 'package:top_heroes_companion_app/persistence/remote/character_database.dart';
import 'package:top_heroes_companion_app/persistence/remote/skills_database.dart';
import 'package:top_heroes_companion_app/persistence/repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Verify database is loaded initialized', () async {
    await SkillsDatabase.instance.initialize;
    final repository = SkillsDatabase.instance;
    expect(repository.skills.isNotEmpty, true);
  });
}
