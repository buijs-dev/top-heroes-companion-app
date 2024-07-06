/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsDatabaseGen {
  const $AssetsDatabaseGen();

  /// File path: assets/database/bonds.yaml
  String get bonds => 'assets/database/bonds.yaml';

  /// File path: assets/database/characters.yaml
  String get characters => 'assets/database/characters.yaml';

  /// File path: assets/database/classes.yaml
  String get classes => 'assets/database/classes.yaml';

  /// File path: assets/database/factions.yaml
  String get factions => 'assets/database/factions.yaml';

  /// File path: assets/database/rarities.yaml
  String get rarities => 'assets/database/rarities.yaml';

  /// File path: assets/database/skills.yaml
  String get skills => 'assets/database/skills.yaml';

  /// List of all assets
  List<String> get values =>
      [bonds, characters, classes, factions, rarities, skills];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/heroes
  $AssetsImagesHeroesGen get heroes => const $AssetsImagesHeroesGen();

  /// File path: assets/images/top_heroes_banner.png
  AssetGenImage get topHeroesBanner =>
      const AssetGenImage('assets/images/top_heroes_banner.png');

  /// File path: assets/images/top_heroes_logo.png
  AssetGenImage get topHeroesLogo =>
      const AssetGenImage('assets/images/top_heroes_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [topHeroesBanner, topHeroesLogo];
}

class $AssetsImagesHeroesGen {
  const $AssetsImagesHeroesGen();

  /// File path: assets/images/heroes/16.webp
  AssetGenImage get a16 => const AssetGenImage('assets/images/heroes/16.webp');

  /// File path: assets/images/heroes/20.webp
  AssetGenImage get a20 => const AssetGenImage('assets/images/heroes/20.webp');

  /// File path: assets/images/heroes/21.webp
  AssetGenImage get a21 => const AssetGenImage('assets/images/heroes/21.webp');

  /// File path: assets/images/heroes/23.webp
  AssetGenImage get a23 => const AssetGenImage('assets/images/heroes/23.webp');

  /// File path: assets/images/heroes/25.webp
  AssetGenImage get a25 => const AssetGenImage('assets/images/heroes/25.webp');

  /// File path: assets/images/heroes/26.webp
  AssetGenImage get a26 => const AssetGenImage('assets/images/heroes/26.webp');

  /// File path: assets/images/heroes/27.webp
  AssetGenImage get a27 => const AssetGenImage('assets/images/heroes/27.webp');

  /// File path: assets/images/heroes/28.webp
  AssetGenImage get a28 => const AssetGenImage('assets/images/heroes/28.webp');

  /// File path: assets/images/heroes/29.webp
  AssetGenImage get a29 => const AssetGenImage('assets/images/heroes/29.webp');

  /// File path: assets/images/heroes/30.webp
  AssetGenImage get a30 => const AssetGenImage('assets/images/heroes/30.webp');

  /// File path: assets/images/heroes/31.webp
  AssetGenImage get a31 => const AssetGenImage('assets/images/heroes/31.webp');

  /// File path: assets/images/heroes/33.webp
  AssetGenImage get a33 => const AssetGenImage('assets/images/heroes/33.webp');

  /// File path: assets/images/heroes/35.webp
  AssetGenImage get a35 => const AssetGenImage('assets/images/heroes/35.webp');

  /// File path: assets/images/heroes/36.webp
  AssetGenImage get a36 => const AssetGenImage('assets/images/heroes/36.webp');

  /// File path: assets/images/heroes/37.webp
  AssetGenImage get a37 => const AssetGenImage('assets/images/heroes/37.webp');

  /// File path: assets/images/heroes/39.webp
  AssetGenImage get a39 => const AssetGenImage('assets/images/heroes/39.webp');

  /// File path: assets/images/heroes/41.webp
  AssetGenImage get a41 => const AssetGenImage('assets/images/heroes/41.webp');

  /// File path: assets/images/heroes/43.webp
  AssetGenImage get a43 => const AssetGenImage('assets/images/heroes/43.webp');

  /// List of all assets
  List<AssetGenImage> get values => [
        a16,
        a20,
        a21,
        a23,
        a25,
        a26,
        a27,
        a28,
        a29,
        a30,
        a31,
        a33,
        a35,
        a36,
        a37,
        a39,
        a41,
        a43
      ];
}

class Assets {
  Assets._();

  static const $AssetsDatabaseGen database = $AssetsDatabaseGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
