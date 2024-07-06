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
import 'package:top_heroes_companion_app/persistence/model/character.dart';
import 'package:top_heroes_companion_app/presentation/features/skill/skill_input_form.dart';

Widget showEditSkillDialog(BuildContext context, Character character) {
  String? name;
  String? description;
  String? star1Bonus;
  String? star2Bonus;
  String? star3Bonus;
  return AlertDialog(
    content: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          right: -40,
          top: -40,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.close, color: Colors.white),
            ),
          ),
        ),
        SkillInputForm(),
      ],
    ),
  );
}
