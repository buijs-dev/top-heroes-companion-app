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

class SkillInputForm extends StatefulWidget {
  const SkillInputForm({super.key});

  @override
  State<SkillInputForm> createState() => _SkillInputFormState();
}

class _SkillInputFormState extends State<SkillInputForm> {
  final formKey = GlobalKey<FormState>();

  String? name;
  String? description;
  Map<int, List<double>> boostByLevel = {1: []};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              maxLines: 1,
              maxLength: 200,
              decoration: const InputDecoration(
                hintText: 'Name of this skill',
                labelText: 'Name *',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              onChanged: (value) {
                name = value;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 3,
              maxLength: 800,
              decoration: const InputDecoration(
                hintText: 'Description of this skill',
                labelText: 'Description *',
              ),
              onChanged: (String? value) {
                description = value;
              },
              validator: (String? value) {
                return value != null ? null : "Required";
              },
            ),
            const SizedBox(height: 20),
            EditComponentBoostByLevel(
                boostByLevel: boostByLevel,
                onEdit: (part, editted) {
                  print('Editted $part: $editted');
                },
                onAdd: (part, added) {
                  setState(() {
                    boostByLevel[part]!.add(added);
                  });
                }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditComponentBoostByLevel extends StatefulWidget {
  const EditComponentBoostByLevel({
    required this.boostByLevel,
    required this.onAdd,
    required this.onEdit,
    super.key,
  });

  final Map<int, List<double>> boostByLevel;
  final void Function(int, double) onAdd;
  final void Function(int, double) onEdit;

  @override
  State<EditComponentBoostByLevel> createState() =>
      _EditComponentBoostByLevelState();
}

class _EditComponentBoostByLevelState extends State<EditComponentBoostByLevel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.boostByLevel.keys
          .map(
            (part) => Row(children: [
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    widget.onAdd(part, 0);
                  }),
              ...widget.boostByLevel[part]!.map(
                (t) => SizedBox(
                  height: 50,
                  width: 50,
                  child: TextFormField(
                    maxLines: 1,
                    maxLength: 20,
                    onChanged: (String? value) {
                      widget.onEdit(part, double.parse(value ?? "0"));
                    },
                    validator: (String? value) {
                      return double.tryParse(value ?? "NaN") == null
                          ? "Not a number"
                          : null;
                    },
                  ),
                ),
              )
            ]),
          )
          .toList(),
    );
  }
}

//               Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: TextFormField(
//                     maxLength: 500,
//                     decoration: const InputDecoration(
//                       hintText: 'Added bonus at star level 1',
//                       labelText: 'Added bonus at star level 1',
//                     ),
//                     onSaved: (String? value) {},
//                     onChanged: (String? value) {
//                       star1Bonus = value;
//                     },
//                   )),
//               Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: TextFormField(
//                     maxLength: 500,
//                     decoration: const InputDecoration(
//                       hintText: 'Added bonus at star level 2',
//                       labelText: 'Added bonus at star level 2',
//                     ),
//                     onSaved: (String? value) {},
//                     onChanged: (String? value) {
//                       star1Bonus = value;
//                     },
//                   )),
//               Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: TextFormField(
//                     maxLength: 500,
//                     decoration: const InputDecoration(
//                       hintText: 'Added bonus at star level 3',
//                       labelText: 'Added bonus at star level 3',
//                     ),
//                     onSaved: (String? value) {},
//                     onChanged: (String? value) {
//                       star1Bonus = value;
//                     },
//                   )),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: ElevatedButton(
//                   style: const ButtonStyle(
//                     backgroundColor:
//                         WidgetStatePropertyAll<Color>(buttonBackgroundColor),
//                   ),
//                   child: const Text('Submit'),
//                   onPressed: () {
//                     final skill = Skill(
//                       name: name!,
//                       description: description!,
//                       boostByLevel: {},
//                       boostAdditional: {},
//                       id: 0,
//                       characterIdList: {},
//                     );
//                     CharacterSkillCache.instance.put(character, skill);
//                     Navigator.of(context, rootNavigator: true).pop();
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
