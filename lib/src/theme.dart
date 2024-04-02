import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'style.dart';
import 'theme_data.dart';

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
              ),
          child: child,
        );
      },
    );
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
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<WxAnchorTheme>();
    if (parentTheme != null) return parentTheme.data;

    final globalTheme = Theme.of(context).extension<WxAnchorThemeData>();
    final defaultTheme = WxAnchorThemeData.defaults(context);
    return defaultTheme.merge(globalTheme);
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
