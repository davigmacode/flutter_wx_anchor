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

  /// The platform, [WxAnchor] should adapt to target.
  ///
  /// Defaults to the current platform, as exposed by [defaultTargetPlatform].
  /// This should be used in order to style UI elements according to platform
  /// conventions.
  ///
  /// Widgets from the material library should use this getter (via [Theme.of])
  /// to determine the current platform for the purpose of emulating the
  /// platform behavior (e.g. scrolling or haptic effects). Widgets and render
  /// objects at lower layers that try to emulate the underlying platform
  /// can depend on [defaultTargetPlatform] directly, or may require
  /// that the target platform be provided as an argument. The
  /// [dart:io.Platform] object should only be used directly when it's critical
  /// to actually know the current platform, without any overrides possible (for
  /// example, when a system API is about to be called).
  ///
  /// In a test environment, the platform returned is [TargetPlatform.android]
  /// regardless of the host platform. (Android was chosen because the tests
  /// were originally written assuming Android-like behavior, and we added
  /// platform adaptations for other platforms later). Tests can check behavior
  /// for other platforms by setting the [platform] of the [Theme] explicitly to
  /// another [TargetPlatform] value, or by setting
  /// [debugDefaultTargetPlatformOverride].
  ///
  /// Determines the defaults for [typography] and [materialTapTargetSize].
  final TargetPlatform platform;

  /// The [AnchorStyle] to be applied to the anchor widget
  final AnchorStyle style;

  /// Creates a theme data that can be used for [AnchorTheme].
  const AnchorThemeData({
    required this.curve,
    required this.duration,
    required this.platform,
    required this.style,
  });

  /// An [AnchorThemeData] with some reasonable default values.
  static final fallback = AnchorThemeData(
    curve: Curves.linear,
    duration: const Duration(milliseconds: 200),
    platform: defaultTargetPlatform,
    style: const AnchorStyle(),
  );

  /// Creates a [AnchorThemeData] from another one that probably null.
  AnchorThemeData.from([AnchorThemeData? other])
      : curve = other?.curve ?? fallback.curve,
        duration = other?.duration ?? fallback.duration,
        platform = other?.platform ?? fallback.platform,
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
    TargetPlatform? platform,
    AnchorStyle? style,
  }) {
    return AnchorThemeData(
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
      platform: platform ?? this.platform,
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
      platform: other.platform,
      style: other.style,
    );
  }

  @override
  AnchorThemeData lerp(ThemeExtension<AnchorThemeData>? other, double t) {
    if (other is! AnchorThemeData) return this;
    return AnchorThemeData(
      curve: lerpEnum(curve, other.curve, t) ?? curve,
      duration: lerpEnum(duration, other.duration, t) ?? duration,
      platform: lerpEnum(platform, other.platform, t) ?? platform,
      style: AnchorStyle.lerp(style, other.style, t) ?? style,
    );
  }

  Map<String, dynamic> toMap() => {
        'curve': curve,
        'duration': duration,
        'platform': platform,
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
