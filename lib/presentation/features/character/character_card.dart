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
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character_color.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character_state.dart';

import '../../../persistence/persistence.dart';
import '../../common/provider.dart';
import 'character_image.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final Widget Function(Character, Image) builder;
  final double? height;
  final double? width;

  const CharacterCard({
    required this.character,
    required this.builder,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final image = character.image;
    precacheImage(image.image, context);
    return Hero(
      tag: character.name,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: character.color,
        child: SizedBox(
          height: height,
          width: width,
          child: builder(character, image),
        ),
      ),
    );
  }
}

class CharacterVerticalCard extends StatelessWidget {
  static const imagePadding = 5.0;

  final Character? character;
  final double width;
  final double? height;

  const CharacterVerticalCard({
    this.character,
    this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final characterNotNull =
        character ?? Provider.of<CharacterState>(context).character;
    return CharacterCard(
      key: ValueKey(characterNotNull.name),
      character: characterNotNull,
      builder: (character, image) => SizedBox(
        width: width,
        height: height,
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.transparent,
                child: Image(
                  image: image.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: AutoSizeText(character.name, maxLines: 1),
                subtitle: AutoSizeText(character.faction.name, maxLines: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
