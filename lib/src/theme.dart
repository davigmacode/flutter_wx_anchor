import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'style.dart';
import 'theme_data.dart';
import 'theme_preset.dart';

/// A Widget that controls how descendant [WxAnchor]s should look like.
class WxAnchorTheme extends InheritedTheme {
  /// The properties for descendant [WxAnchor]s
  final WxAnchorThemeData data;

  /// Creates a theme that controls
  /// how descendant [WxAnchor]s should look like.
  const WxAnchorTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Creates an [WxAnchorTheme] that controls the style of
  /// descendant widgets, and merges in the current [WxAnchorTheme], if any.
  ///
  /// The [child] arguments must not be null.
  static Widget merge({
    Key? key,
    Curve? curve,
    Duration? duration,
    TargetPlatform? platform,
    WxAnchorStyle? style,
    bool? overlay,
    bool? feedback,
    bool? focusable,
    bool? disabled,
    MouseCursor? mouseCursor,
    WxAnchorThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = WxAnchorTheme.of(context);
        return WxAnchorTheme(
          key: key,
          data: parent.merge(data).copyWith(
                curve: curve,
                duration: duration,
                platform: platform,
                style: style,
                overlay: overlay,
                feedback: feedback,
                focusable: focusable,
                disabled: disabled,
                mouseCursor: mouseCursor,
              ),
          child: child,
        );
      },
    );
  }

  /// The [data] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// WxSheetThemeData theme = WxSheetTheme.of(context);
  /// ```
  static WxAnchorThemeData? maybeOf(BuildContext context) {
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<WxAnchorTheme>();
    if (parentTheme != null) return parentTheme.data;

    final globalTheme = Theme.of(context).extension<WxAnchorThemeData>();
    return globalTheme;
  }

  /// The [WxAnchorTheme] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// AnchorThemeData theme = AnchorTheme.of(context);
  /// ```
  static WxAnchorThemeData of(BuildContext context) {
    final parent = WxAnchorTheme.maybeOf(context);
    if (parent != null) return parent;

    return WxAnchorThemeDefaults(context);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return WxAnchorTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(WxAnchorTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WxAnchorThemeData>('data', data));
  }
}
