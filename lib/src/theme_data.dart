import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wx_utils/wx_utils.dart';
import 'style.dart';

/// Defines the visual properties of [WxAnchor].
///
/// Descendant widgets obtain the current [WxAnchorThemeData] object using
/// `WxAnchorTheme.of(context)`. Instances of [WxAnchorThemeData]
/// can be customized with [WxAnchorThemeData.copyWith] or [WxAnchorThemeData.merge].
class WxAnchorThemeData extends ThemeExtension<WxAnchorThemeData>
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

  /// The [WxAnchorStyle] to be applied to the anchor widget
  final WxAnchorStyle style;

  /// Whether the overlay is enabled or not
  final bool overlay;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool feedback;

  /// {@macro flutter.widgets.Focus.canRequestFocus}
  final bool focusable;

  /// Whether the descent [WxAnchor] is disabled for interaction.
  final bool disabled;

  /// Creates a theme data that can be used for [WxAnchorTheme].
  const WxAnchorThemeData({
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 150),
    this.platform = TargetPlatform.android,
    this.style = const WxAnchorStyle(),
    this.overlay = true,
    this.feedback = true,
    this.focusable = true,
    this.disabled = false,
  });

  /// Creates a [WxAnchorThemeData] from another one that probably null.
  WxAnchorThemeData.from([
    WxAnchorThemeData? other,
    WxAnchorThemeData fallback = const WxAnchorThemeData(),
  ])  : curve = other?.curve ?? fallback.curve,
        duration = other?.duration ?? fallback.duration,
        platform = other?.platform ?? fallback.platform,
        style = other?.style ?? fallback.style,
        overlay = other?.overlay ?? fallback.overlay,
        feedback = other?.feedback ?? fallback.feedback,
        focusable = other?.focusable ?? fallback.focusable,
        disabled = other?.disabled ?? fallback.disabled;

  /// Creates a copy of this [WxAnchorThemeData] but with
  /// the given fields replaced with the new values.
  @override
  WxAnchorThemeData copyWith({
    Curve? curve,
    Duration? duration,
    TargetPlatform? platform,
    WxAnchorStyle? style,
    bool? overlay,
    bool? feedback,
    bool? focusable,
    bool? disabled,
  }) {
    return WxAnchorThemeData(
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
      platform: platform ?? this.platform,
      style: this.style.merge(style),
      overlay: overlay ?? this.overlay,
      feedback: feedback ?? this.feedback,
      focusable: focusable ?? this.focusable,
      disabled: disabled ?? this.disabled,
    );
  }

  /// Creates a copy of this [WxAnchorThemeData] but with
  /// the given fields replaced with the new values.
  WxAnchorThemeData merge(WxAnchorThemeData? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      curve: other.curve,
      duration: other.duration,
      platform: other.platform,
      style: other.style,
      overlay: other.overlay,
      feedback: other.feedback,
      focusable: other.focusable,
      disabled: other.disabled,
    );
  }

  @override
  WxAnchorThemeData lerp(ThemeExtension<WxAnchorThemeData>? other, double t) {
    if (other is! WxAnchorThemeData) return this;
    return WxAnchorThemeData(
      curve: lerpEnum(curve, other.curve, t) ?? curve,
      duration: lerpEnum(duration, other.duration, t) ?? duration,
      platform: lerpEnum(platform, other.platform, t) ?? platform,
      style: WxAnchorStyle.lerp(style, other.style, t) ?? style,
      overlay: lerpBool(overlay, other.overlay, t) ?? overlay,
      feedback: lerpBool(feedback, other.feedback, t) ?? feedback,
      focusable: lerpBool(focusable, other.focusable, t) ?? focusable,
      disabled: lerpBool(disabled, other.disabled, t) ?? disabled,
    );
  }

  Map<String, dynamic> toMap() => {
        'curve': curve,
        'duration': duration,
        'platform': platform,
        'style': style,
        'overlay': overlay,
        'feedback': feedback,
        'focusable': focusable,
        'disabled': disabled,
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is WxAnchorThemeData && mapEquals(other.toMap(), toMap());
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
