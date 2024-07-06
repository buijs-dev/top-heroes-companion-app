import 'package:flutter_test/flutter_test.dart';
import 'package:top_heroes_companion_app/persistence/local/character_skill_cache.dart';
import 'package:top_heroes_companion_app/persistence/model/model.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Verify cache is empty when there is nothing cached', () async {
    final cache = CharacterSkillCache.instance;
    cache.initialize();
    cache.skills.isEmpty;

    const character = Character(
      id: 1,
      name: 'Foo',
      rarity: Rarity(id: 1, name: 'Mythic'),
      faction: Faction(
        factionId: FactionId(id: 1, name: 'League'),
        weakness: FactionId(id: 2, name: 'Nature'),
        strength: FactionId(id: 3, name: 'Horde'),
      ),
      classes: {},
      skins: {},
      skills: {},
    );

    const skill = Skill(
      id: 1,
        name: "foo",
        description: "makes foo more bar",
        boostByLevel:{},
        boostAdditional: {}, characterIdList: {},
    );
    cache.put(character, skill);
    final cached = cache.get(character);
    expect(cached.length, 1);
    final cachedSkill = cached.first;
    expect(cachedSkill, skill);
  });
}
