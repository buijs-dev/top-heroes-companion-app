import 'package:flutter/widgets.dart';

import '../../../generated/assets.gen.dart';
import '../../../persistence/persistence.dart';

extension CharacterImage on Character {
  Image get image {
    const assets = $AssetsImagesHeroesGen();
    final identifier = '/$id.webp';
    final matching =
        assets.values.where((agi) => agi.path.endsWith(identifier));
    final asset = matching.lastOrNull ?? const $AssetsImagesGen().topHeroesLogo;
    return asset.image();
  }
}
