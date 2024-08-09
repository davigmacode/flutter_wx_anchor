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

class WxAnchorThemeDefault extends WxAnchorThemePreset {
  WxAnchorThemeDefault(super.context);

  @override
  get style => WxDrivenAnchorStyle(
        textStyle: appTheme.textTheme.labelLarge,
        overlayShape: const RoundedRectangleBorder(),
        overlayOpacity: 0,
        focusedStyle: const WxAnchorStyle(overlayOpacity: 0.15),
        hoveredStyle: const WxAnchorStyle(overlayOpacity: 0.05),
        pressedStyle: const WxAnchorStyle(overlayOpacity: 0.1),
      ).merge(super.style);
}
