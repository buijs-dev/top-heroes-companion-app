// Copyright (c) 2021 - 2024 Buijs Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//F
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
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character_filter.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import '../../../persistence/persistence.dart';
import '../../common/provider.dart';
import '../../layout.dart';
import 'character_card.dart';
import 'character_state.dart';
import 'characters_state.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  static const width = 200.0;
  static const childAspectRatio = 0.6;

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  List<Character> characters = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = getValueForScreenType<bool>(
      context: context,
      mobile: true,
      desktop: false,
    );

    final menu = Container(
      height: size.height,
      width: size.width / 2,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20),
      child: const CharacterFilter(),
    );
    final drawerOrNull = isMobile ? menu : null;
    final drawerButtonOrSizedBox = isMobile
        ? Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          )
        : const SizedBox();

    const minCrossAxisCount = 3;
    final relativeCrossAxisCount =
        MediaQuery.of(context).size.width ~/ CharactersView.width;
    final crossAxisCount = relativeCrossAxisCount < minCrossAxisCount
        ? minCrossAxisCount
        : relativeCrossAxisCount;
    final state = Provider.of<CharactersState>(context);

    Widget itemBuilder(Character character) => GestureDetector(
          key: ValueKey(character.name),
          child: CharacterVerticalCard(
              // key: ValueKey(character.name),
              character: character,
              width: CharactersView.width),
          onTap: () {
            Provider.of<CharacterState>(context).character = character;
            Navigator.of(context).pushNamed('/character?id=${character.id}');
          },
        );

    characters = state.value.toList();

    if (characters.isEmpty) {
      return const Center(child: Text('no matching data found...'));
    }

    final view = WebSmoothScroll(
      controller: _scrollController,
      scrollOffset: 500,
      animationDuration: 1000,
      curve: Curves.linearToEaseOut,
      child: ReorderableBuilder(
        scrollController: _scrollController,
        enableDraggable: false,
        enableScrollingWhileDragging: false,
        automaticScrollExtent: 0,
        children: List.generate(
            characters.length, (int index) => itemBuilder(characters[index])),
        onReorder: (ReorderedListFunction reorderedListFunction) {
          setState(() {
            characters = reorderedListFunction(characters) as List<Character>;
          });
        },
        builder: (children) {
          return GridView(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            key: _gridViewKey,
            cacheExtent: 9999,
            children: children,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: CharactersView.childAspectRatio,
            ),
          );
        },
      ),
    );

    Widget viewWithMenu() {
      final size = MediaQuery.of(context).size;
      const maxWidthMenu = 500.0;
      final relativeWith = size.width * 0.25;
      final widthMenu =
          relativeWith > maxWidthMenu ? maxWidthMenu : relativeWith;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: widthMenu, child: const CharacterFilter()),
          Container(
              width: 0.5,
              height: size.height,
              color: Theme.of(context).dividerColor),
          Expanded(child: view),
        ],
      );
    }

    return Layout(
      child: isMobile ? view : viewWithMenu(),
      navigation: [],
      drawer: drawerOrNull,
    );
  }
}
