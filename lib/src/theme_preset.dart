import 'package:flutter/material.dart';
import 'style.dart';
import 'theme_data.dart';

class WxAnchorThemePreset extends WxAnchorThemeData {
  WxAnchorThemePreset(this.context) : super.from();

  final BuildContext context;

  ThemeData? _appTheme;
  ThemeData get appTheme => _appTheme ??= Theme.of(context);

  @override
  get platform => appTheme.platform;
}

class WxAnchorThemeDefaults extends WxAnchorThemePreset {
  WxAnchorThemeDefaults(super.context);

  @override
  get style => const WxDrivenAnchorStyle(
        shape: RoundedRectangleBorder(),
        overlayDisabled: false,
        overlayOpacity: 0,
        focusedStyle: WxAnchorStyle(overlayOpacity: 0.15),
        hoveredStyle: WxAnchorStyle(overlayOpacity: 0.05),
        pressedStyle: WxAnchorStyle(overlayOpacity: 0.1),
      ).merge(super.style);
}
