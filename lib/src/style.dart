import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:widget_event/widget_event.dart';
import 'package:wx_utils/wx_utils.dart';
import 'event.dart';

/// The style to be applied to anchor widget
@immutable
class WxAnchorStyle with Diagnosticable {
  /// {@template widgetarian.anchor.style.margin}
  /// Empty space to surround the outside anchor.
  /// {@endtemplate}
  final EdgeInsetsGeometry? margin;

  /// {@template widgetarian.anchor.style.padding}
  /// The padding between the contents of the anchor and the outside anchor.
  ///
  /// defaults to [WxAnchorStyle.defaultPadding].
  /// {@endtemplate}
  final EdgeInsetsGeometry? padding;

  /// {@template widgetarian.anchor.style.scale}
  /// The child scale of the anchor when pressed, hovered over, or focused.
  /// {@endtemplate}
  final double? scale;

  /// {@template widgetarian.anchor.style.opacity}
  /// The child opacity of the anchor when pressed, hovered over, or focused.
  /// {@endtemplate}
  final double? opacity;

  /// {@template widgetarian.anchor.style.overlayShape}
  /// The shape (e.g., circle, rectangle) to use for the overlay drawn around
  /// this part of the anchor when pressed, hovered over, or focused.
  /// {@endtemplate}
  final ShapeBorder? overlayShape;

  /// {@template widgetarian.anchor.style.overlayColor}
  /// The overlay color of the anchor when pressed, hovered over, or focused.
  /// {@endtemplate}
  final Color? overlayColor;

  /// {@template widgetarian.anchor.style.overlayOpacity}
  /// The overlay opacity of the anchor when pressed, hovered over, or focused.
  /// {@endtemplate}
  final double? overlayOpacity;

  /// {@template widgetarian.anchor.style.overlayExtent}
  /// The extent of the overlay.
  /// {@endtemplate}
  final Size? overlayExtent;

  /// Create a raw anchor style.
  const WxAnchorStyle({
    this.margin,
    this.padding,
    this.scale,
    this.opacity,
    this.overlayShape,
    this.overlayColor,
    this.overlayOpacity,
    this.overlayExtent,
  });

  /// Create an anchor style with rectangle shape.
  WxAnchorStyle.rectangle({
    BorderRadius borderRadius = BorderRadius.zero,
    this.margin,
    this.padding,
    this.scale,
    this.opacity,
    this.overlayColor,
    this.overlayOpacity,
    this.overlayExtent,
  }) : overlayShape = RoundedRectangleBorder(borderRadius: borderRadius);

  /// Create an anchor style with circle shape.
  WxAnchorStyle.circle({
    this.margin,
    this.padding,
    this.scale,
    this.opacity,
    this.overlayColor,
    this.overlayOpacity,
    double? overlayRadius,
  })  : overlayShape = const CircleBorder(),
        overlayExtent =
            overlayRadius != null ? Size.fromRadius(overlayRadius) : null;

  /// Create a [WxAnchorStyle] from another style
  WxAnchorStyle.from(WxAnchorStyle? other)
      : margin = other?.margin,
        padding = other?.padding,
        scale = other?.scale,
        opacity = other?.opacity,
        overlayShape = other?.overlayShape,
        overlayColor = other?.overlayColor,
        overlayOpacity = other?.overlayOpacity,
        overlayExtent = other?.overlayExtent;

  /// Creates a copy of this [WxAnchorStyle] but with
  /// the given fields replaced with the new values.
  WxAnchorStyle copyWith({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? scale,
    double? opacity,
    ShapeBorder? overlayShape,
    Color? overlayColor,
    double? overlayOpacity,
    Size? overlayExtent,
    bool? inherits,
  }) {
    return WxAnchorStyle(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      scale: scale ?? this.scale,
      opacity: opacity ?? this.opacity,
      overlayShape: overlayShape ?? this.overlayShape,
      overlayColor: overlayColor ?? this.overlayColor,
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
      overlayExtent: overlayExtent ?? this.overlayExtent,
    );
  }

  /// Creates a copy of this [WxAnchorStyle] but with
  /// the given fields replaced with the new values.
  WxAnchorStyle merge(WxAnchorStyle? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      margin: other.margin,
      padding: other.padding,
      scale: other.scale,
      opacity: other.opacity,
      overlayShape: other.overlayShape,
      overlayColor: other.overlayColor,
      overlayOpacity: other.overlayOpacity,
      overlayExtent: other.overlayExtent,
    );
  }

  /// Linearly interpolate between two [WxAnchorStyle] objects.
  static WxAnchorStyle? lerp(WxAnchorStyle? a, WxAnchorStyle? b, double t) {
    if (a == null && b == null) return null;
    return WxAnchorStyle(
      margin: EdgeInsetsGeometry.lerp(a?.margin, b?.margin, t),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
      scale: lerpDouble(a?.scale, b?.scale, t),
      opacity: lerpDouble(a?.opacity, b?.opacity, t),
      overlayShape: ShapeBorder.lerp(a?.overlayShape, b?.overlayShape, t),
      overlayColor: Color.lerp(a?.overlayColor, b?.overlayColor, t),
      overlayOpacity: lerpDouble(a?.overlayOpacity, b?.overlayOpacity, t),
      overlayExtent: Size.lerp(a?.overlayExtent, b?.overlayExtent, t),
    );
  }

  Map<String, dynamic> toMap() => {
        'margin': margin,
        'padding': padding,
        'scale': scale,
        'opacity': opacity,
        'overlayShape': overlayShape,
        'overlayColor': overlayColor,
        'overlayOpacity': overlayOpacity,
        'overlayExtent': overlayExtent,
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is WxAnchorStyle && mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => Object.hashAll(toMap().values);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    toMap().entries.forEach((el) {
      properties.add(DiagnosticsProperty(el.key, el.value));
    });
  }
}

/// Create a [WxAnchorStyle] that can handle widget event.
class WxDrivenAnchorStyle extends WxAnchorStyle
    implements DrivenProperty<WxAnchorStyle> {
  /// Whether the resolved style is merged to
  /// the previous resolved style or not
  final bool? inherits;

  /// The style to be resolved when
  /// events includes [WxAnchorEvent.focused].
  final WxAnchorStyle? focusedStyle;

  /// The style to be resolved when
  /// events includes [WxAnchorEvent.hovered].
  final WxAnchorStyle? hoveredStyle;

  /// The style to be resolved when
  /// events includes [WxAnchorEvent.pressed].
  final WxAnchorStyle? pressedStyle;

  /// The style to be resolved when
  /// events includes [WxAnchorEvent.disabled].
  final WxAnchorStyle? disabledStyle;

  /// Map of driven style, order matters
  Map<WidgetEvent, WxAnchorStyle?> get driven => {
        WidgetEvent.focused: focusedStyle,
        WidgetEvent.hovered: hoveredStyle,
        WidgetEvent.pressed: pressedStyle,
        WidgetEvent.disabled: disabledStyle,
      };

  /// Create a rectangle shaped [WxDrivenAnchorStyle].
  const WxDrivenAnchorStyle({
    super.margin,
    super.padding,
    super.scale,
    super.opacity,
    super.overlayShape,
    super.overlayExtent,
    super.overlayColor,
    super.overlayOpacity,
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.disabledStyle,
    this.inherits,
  });

  /// Create a circle shaped [WxDrivenAnchorStyle].
  WxDrivenAnchorStyle.circle({
    super.margin,
    super.padding,
    super.scale,
    super.opacity,
    super.overlayColor,
    super.overlayOpacity,
    super.overlayRadius,
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.disabledStyle,
    this.inherits,
  }) : super.circle();

  /// Default constructor for a driven [WxAnchorStyle].
  WxDrivenAnchorStyle.rectangle({
    super.borderRadius,
    super.margin,
    super.padding,
    super.scale,
    super.opacity,
    super.overlayColor,
    super.overlayOpacity,
    super.overlayExtent,
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.disabledStyle,
    this.inherits,
  }) : super.rectangle();

  /// Create a [WxDrivenAnchorStyle] with value
  /// from another [WxAnchorStyle].
  WxDrivenAnchorStyle.fromAncestor(
    super.enabled, {
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.disabledStyle,
    this.inherits,
  }) : super.from();

  /// Create a [WxDrivenAnchorStyle] from a resolver callback
  WxDrivenAnchorStyle.resolver(
    DrivenPropertyResolver<WxAnchorStyle?> resolver, {
    this.inherits = false,
  })  : focusedStyle = resolver({WidgetEvent.focused}),
        hoveredStyle = resolver({WidgetEvent.hovered}),
        pressedStyle = resolver({WidgetEvent.pressed}),
        disabledStyle = resolver({WidgetEvent.disabled}),
        super.from(resolver({}));

  /// Resolves the value for the given set of events
  /// if `value` is an event driven [WxAnchorStyle],
  /// otherwise returns the value itself.
  static WxAnchorStyle? evaluate(
      WxAnchorStyle? value, Set<WidgetEvent> events) {
    return DrivenProperty.evaluate<WxAnchorStyle?>(value, events);
  }

  @override
  WxAnchorStyle resolve(Set<WidgetEvent> events) {
    WxAnchorStyle style = this;
    for (var e in driven.entries) {
      if (events.contains(e.key)) {
        final evaluated = evaluate(e.value, events);
        style = style.merge(evaluated);
      }
    }
    return style;
  }

  /// Creates a copy of this [WxAnchorStyle] but with
  /// the given fields replaced with the new values.
  @override
  WxDrivenAnchorStyle copyWith({
    margin,
    padding,
    scale,
    opacity,
    overlayColor,
    overlayOpacity,
    overlayShape,
    overlayExtent,
    WxAnchorStyle? focusedStyle,
    WxAnchorStyle? hoveredStyle,
    WxAnchorStyle? pressedStyle,
    WxAnchorStyle? disabledStyle,
    bool? inherits,
  }) {
    final ancestor = super.copyWith(
      margin: margin,
      padding: padding,
      scale: scale,
      opacity: opacity,
      overlayColor: overlayColor,
      overlayOpacity: overlayOpacity,
      overlayShape: overlayShape,
      overlayExtent: overlayExtent,
    );
    return WxDrivenAnchorStyle.fromAncestor(
      ancestor,
      inherits: inherits ?? this.inherits,
      focusedStyle: this.focusedStyle?.merge(focusedStyle) ?? focusedStyle,
      hoveredStyle: this.hoveredStyle?.merge(hoveredStyle) ?? hoveredStyle,
      pressedStyle: this.pressedStyle?.merge(pressedStyle) ?? pressedStyle,
      disabledStyle: this.disabledStyle?.merge(disabledStyle) ?? disabledStyle,
    );
  }

  @override
  WxDrivenAnchorStyle merge(WxAnchorStyle? other) {
    final result = WxDrivenAnchorStyle.fromAncestor(
      super.merge(other),
      inherits: inherits,
      focusedStyle: focusedStyle,
      hoveredStyle: hoveredStyle,
      pressedStyle: pressedStyle,
      disabledStyle: disabledStyle,
    );

    if (other is WxDrivenAnchorStyle) {
      return result.copyWith(
        inherits: other.inherits,
        focusedStyle: other.focusedStyle,
        hoveredStyle: other.hoveredStyle,
        pressedStyle: other.pressedStyle,
        disabledStyle: other.disabledStyle,
      );
    }
    return result;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('inherits', inherits));
    properties.add(DiagnosticsProperty('focusedStyle', focusedStyle));
    properties.add(DiagnosticsProperty('hoveredStyle', hoveredStyle));
    properties.add(DiagnosticsProperty('pressedStyle', pressedStyle));
    properties.add(DiagnosticsProperty('disabledStyle', disabledStyle));
  }
}
