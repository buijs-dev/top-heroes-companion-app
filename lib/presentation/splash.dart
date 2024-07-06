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
import 'package:top_heroes_companion_app/generated/assets.gen.dart';

import '../persistence/repository.dart';

class SplashConfiguration {
  /// Duration to wait before displaying the splash image.
  ///
  /// When this duration is exceeded, the opacity of the splash image is adjusted
  /// and it will be gradually made visible.
  final Duration imageFadeInTime;

  /// Duration to wait before hiding the splash image.
  ///
  /// When this duration is exceeded, the opacity of the splash image is adjusted
  /// and it will be gradually made invisible. This duration starts after all
  /// initialization tasks are done. When initialization takes a long time,
  /// it is preferable to set this variable to zero.
  final Duration imageFadeOutTime;

  /// Duration to wait before rerouting from [SplashPage] to the next page.
  ///
  /// The purpose of this delay is to smoothly finish the splash image animation,
  /// before rerouting.
  final Duration rerouteDelay;

  /// Named page to reroute to.
  final String rerouteTarget;

  /// Widget to display when initialization was unsuccessfully.
  final Widget errorWidget;

  const SplashConfiguration({
    required this.imageFadeOutTime,
    required this.rerouteDelay,
    required this.imageFadeInTime,
    required this.rerouteTarget,
    required this.errorWidget,
  });
}

class SplashPage extends StatefulWidget {
  const SplashPage({required this.configuration, super.key});

  final SplashConfiguration configuration;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Widget child;

  late double opacity;

  @override
  void initState() {
    super.initState();
    child = const $AssetsImagesGen().topHeroesLogo.image();
    opacity = 0.0;
    Future.delayed(widget.configuration.imageFadeInTime).then((_) {
      setState(() {
        opacity = 1.0;
      });
      initializeRepository().then((repository) {
        if (repository == null) {
          setState(() {
            child = widget.configuration.errorWidget;
          });
        } else {
          Future.delayed(widget.configuration.imageFadeOutTime).then((_) {
            setState(() {
              opacity = 0.0;
            });
            Future.delayed(widget.configuration.rerouteDelay).then((_) {
              Navigator.of(context)
                  .pushReplacementNamed(widget.configuration.rerouteTarget);
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(seconds: 1),
      child: child,
    );
  }
}
