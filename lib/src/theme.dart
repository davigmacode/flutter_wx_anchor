import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'style.dart';
import 'theme_data.dart';

/// A Widget that controls how descendant [Anchor]s should look like.
class AnchorTheme extends InheritedTheme {
  /// The properties for descendant [Anchor]s
  final AnchorThemeData data;

  /// Creates a theme that controls
  /// how descendant [Anchor]s should look like.
  const AnchorTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Creates an [AnchorTheme] that controls the style of
  /// descendant widgets, and merges in the current [AnchorTheme], if any.
  ///
  /// The [child] arguments must not be null.
  static Widget merge({
    Key? key,
    Curve? curve,
    Duration? duration,
    TargetPlatform? platform,
    AnchorStyle? style,
    AnchorThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = AnchorTheme.of(context);
        return AnchorTheme(
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

  /// The [AnchorTheme] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// AnchorThemeData theme = AnchorTheme.of(context);
  /// ```
  static AnchorThemeData of(BuildContext context) {
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<AnchorTheme>();
    if (parentTheme != null) return parentTheme.data;

    final globalTheme = Theme.of(context).extension<AnchorThemeData>();
    final defaultTheme = AnchorThemeData.defaults(context);
    return defaultTheme.merge(globalTheme);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AnchorTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(AnchorTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AnchorThemeData>('data', data));
  }
}
