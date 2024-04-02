import 'package:flutter/material.dart';
import 'style.dart';
import 'theme_data.dart';

@immutable
class AnchorThemeDefaults extends AnchorThemeData {
  AnchorThemeDefaults(BuildContext context)
      : super.from(AnchorThemeData.fallback.copyWith(
          platform: Theme.of(context).platform,
        ));

  @override
  get style => const DrivenAnchorStyle(
        shape: BoxShape.rectangle,
        overlayDisabled: false,
        overlayOpacity: 0,
        focusedStyle: AnchorStyle(overlayOpacity: 0.15),
        hoveredStyle: AnchorStyle(overlayOpacity: 0.05),
        pressedStyle: AnchorStyle(overlayOpacity: 0.1),
      ).merge(super.style);
}
