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

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_heroes_companion_app/presentation/features/character/character.dart';
import 'package:top_heroes_companion_app/presentation/features/character/characters.dart';

import 'presentation/common/provider.dart';
import 'presentation/features/character/character_state.dart';
import 'presentation/features/character/characters_state.dart';
import 'presentation/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopHeroes!',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.flutterDash)
          .copyWith(textTheme: GoogleFonts.chivoMonoTextTheme()),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        final path = settings.name;
        if (path == null) {
          return null;
        }

        final uri = Uri.parse(path);
        final segments = uri.pathSegments;
        if (segments.last == "character") {
          final characterId = int.tryParse(uri.queryParameters['id'] ?? '');
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => Provider(
                  notifier: CharactersState(),
                  child: Provider(
                      notifier: CharacterState(),
                      child: CharacterView(characterId: characterId))));
        }

        return null;
      },
      routes: {
        '/': (context) => const SplashPage(
              configuration: SplashConfiguration(
                rerouteTarget: '/characters',
                errorWidget: Text('oops something went wrong...'),
                imageFadeInTime: Duration(milliseconds: 500),
                imageFadeOutTime: Duration(milliseconds: 1000),
                rerouteDelay: Duration(milliseconds: 1000),
              ),
            ),
        '/characters': (context) => Provider(
            notifier: CharactersState(),
            child: Provider(
                notifier: CharacterState(), child: const CharactersView())),
        '/character': (context) => Provider(
            notifier: CharactersState(),
            child: Provider(
                notifier: CharacterState(), child: const CharacterView())),
      },
    );
  }
}
