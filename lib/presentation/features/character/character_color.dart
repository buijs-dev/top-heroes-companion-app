import 'package:flutter/material.dart';
import 'package:top_heroes_companion_app/persistence/persistence.dart';

extension CharacterColor on Character {
  Color get color => switch (faction.id) {
        1 => Colors.blue.withOpacity(0.7),
        2 => Colors.green.withOpacity(0.7),
        3 => Colors.red.withOpacity(0.7),
        _ => Colors.grey
      };
}
