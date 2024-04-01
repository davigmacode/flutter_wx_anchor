import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wx_utils/wx_utils.dart';
import 'style.dart';
import 'theme_preset.dart';

/// Defines the visual properties of [Anchor].
///
/// Descendant widgets obtain the current [AnchorThemeData] object using
/// `AnchorTheme.of(context)`. Instances of [AnchorThemeData]
/// can be customized with [AnchorThemeData.copyWith] or [AnchorThemeData.merge].
@immutable
class AnchorThemeData extends ThemeExtension<AnchorThemeData>
    with Diagnosticable {
  /// The curve to apply when animating the parameters of anchor widget.
  final Curve curve;

  /// The duration over which to animate the parameters of anchor widget.
  final Duration duration;

  /// The [AnchorStyle] to be applied to the anchor widget
  final AnchorStyle style;

  /// Creates a theme data that can be used for [AnchorTheme].
  const AnchorThemeData({
    required this.curve,
    required this.duration,
    required this.style,
  });

  /// An [AnchorThemeData] with some reasonable default values.
  static const fallback = AnchorThemeData(
    curve: Curves.linear,
    duration: Duration(milliseconds: 200),
    style: AnchorStyle(),
  );

  /// Creates a [AnchorThemeData] from another one that probably null.
  AnchorThemeData.from([AnchorThemeData? other])
      : curve = other?.curve ?? fallback.curve,
        duration = other?.duration ?? fallback.duration,
        style = other?.style ?? fallback.style;

  /// A [AnchorThemeData] with default values.
  factory AnchorThemeData.defaults(BuildContext context) =>
      AnchorThemeDefaults(context);

  /// Creates a copy of this [AnchorThemeData] but with
  /// the given fields replaced with the new values.
  @override
  AnchorThemeData copyWith({
    Curve? curve,
    Duration? duration,
    AnchorStyle? style,
  }) {
    return AnchorThemeData(
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
      style: this.style.merge(style),
    );
  }

  /// Creates a copy of this [AnchorThemeData] but with
  /// the given fields replaced with the new values.
  AnchorThemeData merge(AnchorThemeData? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      curve: other.curve,
      duration: other.duration,
      style: other.style,
    );
  }

  @override
  AnchorThemeData lerp(ThemeExtension<AnchorThemeData>? other, double t) {
    if (other is! AnchorThemeData) return this;
    return AnchorThemeData(
      curve: lerpEnum(curve, other.curve, t) ?? curve,
      duration: lerpEnum(duration, other.duration, t) ?? duration,
      style: AnchorStyle.lerp(style, other.style, t) ?? style,
    );
  }

  Map<String, dynamic> toMap() => {
        'curve': curve,
        'duration': duration,
        'style': style,
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is AnchorThemeData && mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => Object.hashAll(toMap().values);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    toMap().entries.forEach((el) {
      properties.add(DiagnosticsProperty(el.key, el.value, defaultValue: null));
    });
  }
}
