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
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character_card.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character_color.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character_state.dart';
import 'package:top_heroes_companion_app/presentation/layout.dart';

import '../../../persistence/model/character.dart';
import '../../common/provider.dart';
import '../skill/edit_skill_dialog.dart';
import 'characters.dart';
import 'characters_state.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({
    this.characterId,
    super.key,
  });

  final int? characterId;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final character = getCharacter(context);
    final menu = Container(
      height: size.height,
      width: size.width / 2,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20),
      child: const Text('nothing here yet...'),
    );

    final isMobile = getValueForScreenType<bool>(
      context: context,
      mobile: true,
      desktop: false,
    );
    final drawerOrNull = isMobile ? menu : null;
    return Layout(
      navigation: [],
      drawer: drawerOrNull,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: character.color,
              height: size.height * 0.4,
            ),
            _RowText(title: 'Name', content: character.name),
            _RowText(title: 'Faction', content: character.faction.name),
            const SizedBox(height: 20),
            Text('Classes', style: Theme.of(context).textTheme.headlineSmall),
            ...character.classes.map((attribute) => _RowText(
                title: attribute.name, content: attribute.description)),
            const SizedBox(height: 20),
            Text('Skins', style: Theme.of(context).textTheme.headlineSmall),
            if (character.skins.isEmpty) const Text('None'),
            ...character.skins
                .map((skin) => _RowText(title: 'Skin', content: skin.name)),
            const SizedBox(height: 20),
            Row(children: [
              Text('Skills', style: Theme.of(context).textTheme.headlineSmall),
              IconButton(
                  onPressed: () async {
                    await showDialog<void>(
                        context: context,
                        builder: (context) =>
                            showEditSkillDialog(context, character));
                  },
                  icon: const Icon(Icons.edit))
            ]),
            if (character.skills.isEmpty) const Text('None'),
            ...character.skills.map((skill) =>
                _RowText(title: skill.name, content: skill.description))
          ],
        ),
    );
  }
}

class _RowText extends StatelessWidget {
  const _RowText({required this.title, required this.content, super.key});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: title, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ': $content'),
        ],
      ),
    );
  }
}

extension on CharacterView {
  /// Get [Character] data to display by finding a match for the specified id or loading a Character from the [CharacterState].
  ///
  /// CharacterState is updated if the specified [characterId] is not null, valid and matches a different character then currently
  /// in the [CharacterState].
  Character getCharacter(BuildContext context) {
    final state = Provider.of<CharacterState>(context);
    final stateCharacter = state.character;
    if (characterId == null) {
      return stateCharacter;
    }

    final characters = Provider.of<CharactersState>(context).data;
    final character = characters.firstWhere((c) => c.id == characterId,
        orElse: () => Provider.of<CharacterState>(context).character);

    if (stateCharacter != character) {
      state.character = character;
    }

    return character;
  }
}