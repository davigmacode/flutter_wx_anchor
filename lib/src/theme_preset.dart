import 'package:flutter/material.dart';
import 'style.dart';
import 'theme_data.dart';

@immutable
class WxAnchorThemeDefaults extends WxAnchorThemeData {
  WxAnchorThemeDefaults(BuildContext context)
      : super.from(WxAnchorThemeData.fallback.copyWith(
          platform: Theme.of(context).platform,
        ));

  @override
  get style => const WxDrivenAnchorStyle(
        shape: BoxShape.rectangle,
        overlayDisabled: false,
        overlayOpacity: 0,
        focusedStyle: WxAnchorStyle(overlayOpacity: 0.15),
        hoveredStyle: WxAnchorStyle(overlayOpacity: 0.05),
        pressedStyle: WxAnchorStyle(overlayOpacity: 0.1),
      ).merge(super.style);
}
