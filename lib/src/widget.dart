import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_event/widget_event.dart';
import 'overlay.dart';
import 'style.dart';
import 'theme.dart';
import 'feedback.dart';

/// An area that responds to touch.
/// Has a configurable shape and can be configured
/// to clip overlay that extend outside its bounds or not.
class WxAnchor extends StatelessWidget {
  /// Creates an area that responds to touch.
  const WxAnchor({
    super.key,
    this.curve,
    this.duration,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onHover,
    this.onFocus,
    this.scale,
    this.opacity,
    this.overlayDisabled,
    this.overlayColor,
    this.overlayOpacity,
    this.mouseCursor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.style,
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.disabledStyle,
    this.eventsController,
    this.focusNode,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.feedbackDisabled = false,
    this.disabled = false,
    this.child,
  })  : shape = null,
        radius = null;

  /// Creates a circle shaped area that responds to touch.
  const WxAnchor.circle({
    super.key,
    this.curve,
    this.duration,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onHover,
    this.onFocus,
    this.scale,
    this.opacity,
    this.overlayDisabled,
    this.overlayColor,
    this.overlayOpacity,
    this.mouseCursor,
    this.radius,
    this.padding,
    this.margin,
    this.style,
    this.focusedStyle,
    this.hoveredStyle,
    this.pressedStyle,
    this.disabledStyle,
    this.eventsController,
    this.focusNode,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.feedbackDisabled = false,
    this.disabled = false,
    this.child,
  })  : shape = BoxShape.circle,
        borderRadius = null;

  /// The curve to apply when animating
  /// the parameters of this widget.
  final Curve? curve;

  /// The duration over which to animate
  /// the parameters of this widget.
  final Duration? duration;

  /// Called when the user taps
  final VoidCallback? onTap;

  /// Called when the user releases a tap that was started on
  final GestureTapUpCallback? onTapUp;

  /// Called when the user taps down
  final GestureTapDownCallback? onTapDown;

  /// Called when the user cancels a tap that was started on
  final VoidCallback? onTapCancel;

  /// Called when the user double taps
  final VoidCallback? onDoubleTap;

  /// Called when the user long-presses
  final VoidCallback? onLongPress;

  /// Called when a pointer enters or exits the anchor area.
  final ValueChanged<bool>? onHover;

  /// Handler called when the focus changes.
  final ValueChanged<bool>? onFocus;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// {@macro widgetarian.anchor.style.scale}
  final double? scale;

  /// {@macro widgetarian.anchor.style.opacity}
  final double? opacity;

  /// {@macro widgetarian.anchor.style.overlayDisabled}
  final bool? overlayDisabled;

  /// {@macro widgetarian.anchor.style.overlayColor}
  final Color? overlayColor;

  /// {@macro widgetarian.anchor.style.overlayOpacity}
  final double? overlayOpacity;

  /// {@macro widgetarian.anchor.style.borderRadius}
  final BorderRadius? borderRadius;

  /// {@macro widgetarian.anchor.style.radius}
  final double? radius;

  /// {@macro widgetarian.anchor.style.shape}
  final BoxShape? shape;

  /// {@macro widgetarian.anchor.style.padding}
  final EdgeInsetsGeometry? padding;

  /// {@macro widgetarian.anchor.style.margin}
  final EdgeInsetsGeometry? margin;

  /// The [WxAnchorStyle] to apply
  final WxAnchorStyle? style;

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

  /// Used by widgets that expose their internal event
  /// for the sake of extensions that add support for additional events.
  final WidgetEventController? eventsController;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.canRequestFocus}
  final bool canRequestFocus;

  /// Whether detected gestures should disable acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool feedbackDisabled;

  /// Whether or not this widget is disabled for interaction.
  final bool disabled;

  /// The widget below this widget in the tree.
  final Widget? child;

  WxAnchorStyle get effectiveStyle {
    return const WxAnchorStyle().merge(style).copyWith(
          margin: margin,
          padding: padding,
          shape: shape,
          radius: radius,
          borderRadius: borderRadius,
          scale: scale,
          opacity: opacity,
          overlayColor: overlayColor,
          overlayOpacity: overlayOpacity,
          overlayDisabled: overlayDisabled,
          focusedStyle: focusedStyle,
          hoveredStyle: hoveredStyle,
          pressedStyle: pressedStyle,
          disabledStyle: disabledStyle,
        );
  }

  @override
  Widget build(BuildContext context) {
    final anchorTheme = WxAnchorTheme.of(context);
    final themedStyle = anchorTheme.style.merge(effectiveStyle);
    final parentState = _WxAnchorRenderProvider.of(context);
    return _WxAnchorRender(
      parentState: parentState,
      curve: curve ?? anchorTheme.curve,
      duration: duration ?? anchorTheme.duration,
      platform: anchorTheme.platform,
      onTap: onTap,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocus: onFocus,
      mouseCursor: mouseCursor,
      eventsController: eventsController,
      focusNode: focusNode,
      autofocus: autofocus,
      canRequestFocus: canRequestFocus,
      feedbackDisabled: feedbackDisabled,
      disabled: disabled,
      style: themedStyle,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final List<String> gestures = <String>[
      if (onTap != null) 'tap',
      if (onDoubleTap != null) 'double tap',
      if (onLongPress != null) 'long press',
      if (onTapDown != null) 'tap down',
      if (onTapUp != null) 'tap up',
      if (onTapCancel != null) 'tap cancel',
    ];
    properties
        .add(IterableProperty<String>('gestures', gestures, ifEmpty: '<none>'));
    properties.add(DiagnosticsProperty<bool>('disabled', disabled));
    properties
        .add(DiagnosticsProperty<bool>('feedbackDisabled', feedbackDisabled));
    properties
        .add(DiagnosticsProperty<bool>('canRequestFocus', canRequestFocus));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus));
    properties.add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode));
    properties.add(DiagnosticsProperty<WidgetEventController?>(
        'eventsController', eventsController));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry?>('margin', margin));
    properties
        .add(DiagnosticsProperty<EdgeInsetsGeometry?>('padding', padding));
    properties.add(EnumProperty<BoxShape>('shape', shape));
    properties.add(DoubleProperty('radius', radius));
    properties
        .add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius));
    properties.add(DoubleProperty('overlayOpacity', overlayOpacity));
    properties.add(ColorProperty('overlayColor', overlayColor));
    properties
        .add(DiagnosticsProperty<bool>('overlayDisabled', overlayDisabled));
    properties
        .add(DiagnosticsProperty<MouseCursor?>('mouseCursor', mouseCursor));
    properties.add(DiagnosticsProperty<WxAnchorStyle?>('style', style));
    properties.add(
        DiagnosticsProperty<WxAnchorStyle>('effectiveStyle', effectiveStyle));
  }
}

class _WxAnchorRender extends StatefulWidget {
  const _WxAnchorRender({
    this.parentState,
    required this.curve,
    required this.duration,
    required this.platform,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onHover,
    this.onFocus,
    this.mouseCursor,
    this.eventsController,
    this.focusNode,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.feedbackDisabled = false,
    this.disabled = false,
    required this.style,
    this.child,
  });

  final _WxAnchorRenderState? parentState;
  final Curve curve;
  final Duration duration;
  final TargetPlatform platform;
  final VoidCallback? onTap;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final VoidCallback? onTapCancel;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final MouseCursor? mouseCursor;
  final WidgetEventController? eventsController;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool canRequestFocus;
  final bool feedbackDisabled;
  final bool disabled;
  final WxAnchorStyle style;
  final Widget? child;

  bool get enabled => !disabled;

  bool get clickable => [
        onTap,
        onTapUp,
        onTapDown,
        onTapCancel,
        onDoubleTap,
        onLongPress
      ].any((e) => e != null);

  MouseCursor get defaultMouseCursor =>
      clickable ? DrivenMouseCursor.clickable : MouseCursor.defer;

  @override
  State<_WxAnchorRender> createState() => _WxAnchorRenderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

class _WxAnchorRenderState extends State<_WxAnchorRender>
    with WidgetEventMixin<_WxAnchorRender> {
  bool childrenActive = false;

  PointerDeviceKind? pointerDeviceKind;

  WxAnchorStyle style = const WxAnchorStyle();

  @protected
  void setStyle() {
    final raw = widget.style;
    final resolved = WxDrivenAnchorStyle.evaluate(raw, widgetEvents.value);
    style = style.merge(resolved);
  }

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ??
        NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return widget.enabled && widget.canRequestFocus;
      case NavigationMode.directional:
        return true;
    }
  }

  void _onTap() {
    if (!childrenActive) {
      if (widget.onTap != null) {
        if (!widget.feedbackDisabled) {
          Feedback.forTap(context, widget.platform);
        }
        widget.onTap?.call();
      }
    }
  }

  void _onTapCancel() async {
    if (pointerDeviceKind == PointerDeviceKind.touch) {
      await Future.delayed(widget.duration);
    }
    pointerDeviceKind = null;
    widgetEvents.toggle(WidgetEvent.pressed, false);
    widget.parentState?.childrenActive = false;
    widget.onTapCancel?.call();
  }

  void _onTapUp(TapUpDetails details) async {
    if (details.kind == PointerDeviceKind.touch) {
      await Future.delayed(widget.duration);
    }
    pointerDeviceKind = null;
    widgetEvents.toggle(WidgetEvent.pressed, false);
    widget.parentState?.childrenActive = false;
    widget.onTapUp?.call(details);
  }

  void _onTapDown(TapDownDetails details) {
    if (!childrenActive) {
      pointerDeviceKind = details.kind;
      widgetEvents.toggle(WidgetEvent.pressed, true);
      widget.parentState?.childrenActive = true;
      widget.onTapDown?.call(details);
    }
  }

  void _onHover(bool value) {
    widgetEvents.toggle(WidgetEvent.hovered, value);
    widget.onHover?.call(value);
    widget.parentState?.childrenActive = value;
  }

  void _onFocus(bool value) {
    widgetEvents.toggle(WidgetEvent.focused, value);
    widget.onFocus?.call(value);
  }

  @override
  void initState() {
    initWidgetEvents(widget.eventsController);
    widgetEvents.toggle(WidgetEvent.disabled, widget.disabled);
    setStyle();
    super.initState();
  }

  @override
  void didUpdateWidget(_WxAnchorRender oldWidget) {
    if (mounted) {
      updateWidgetEvents(oldWidget.eventsController, widget.eventsController);
      widgetEvents.toggle(WidgetEvent.disabled, widget.disabled);
      super.didUpdateWidget(oldWidget);
    }
  }

  @override
  void didChangeWidgetEvents() {
    if (mounted) {
      setStyle();
      super.didChangeWidgetEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget result = _WxAnchorRenderProvider(
      state: this,
      child: widget.child,
    );

    if (style.padding != null) {
      result = Padding(padding: style.padding!, child: result);
    }

    if (widget.enabled && widget.clickable) {
      result = GestureDetector(
        onTap: _onTap,
        onTapUp: _onTapUp,
        onTapDown: _onTapDown,
        onTapCancel: _onTapCancel,
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongPress,
        behavior: HitTestBehavior.opaque,
        excludeFromSemantics: true,
        child: result,
      );
    }

    final rawMouse = widget.mouseCursor ?? widget.defaultMouseCursor;
    final resMouse = DrivenProperty.evaluate(rawMouse, widgetEvents.value);
    result = Focus(
      onFocusChange: _onFocus,
      canRequestFocus: _canRequestFocus,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      child: MouseRegion(
        opaque: true,
        hitTestBehavior: HitTestBehavior.opaque,
        cursor: resMouse,
        onEnter: (event) => _onHover(true),
        onExit: (event) => _onHover(false),
        child: result,
      ),
    );

    if (widget.clickable) {
      result = AnimatedScale(
        scale: style.scale ?? 1,
        curve: widget.curve,
        duration: widget.duration,
        child: result,
      );
    }

    if (widget.clickable) {
      result = AnimatedOpacity(
        opacity: style.opacity ?? 1,
        curve: widget.curve,
        duration: widget.duration,
        child: result,
      );
    }

    if (style.overlayEnabled && widget.enabled && widget.clickable) {
      result = AnimatedOverlay(
        curve: widget.curve,
        duration: widget.duration,
        shape: style.shape,
        radius: style.radius,
        borderRadius: style.borderRadius,
        color: style.overlayColor,
        opacity: style.overlayOpacity,
        child: result,
      );
    }

    if (style.margin != null) {
      result = Padding(padding: style.margin!, child: result);
    }

    return result;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

class _WxAnchorRenderProvider extends InheritedWidget {
  const _WxAnchorRenderProvider({
    required this.state,
    required Widget? child,
  }) : super(child: child ?? const _WxAnchorPlaceholder());

  final _WxAnchorRenderState state;

  @override
  bool updateShouldNotify(_WxAnchorRenderProvider oldWidget) =>
      state != oldWidget.state;

  static _WxAnchorRenderState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_WxAnchorRenderProvider>()
        ?.state;
  }
}

class _WxAnchorPlaceholder extends StatelessWidget {
  const _WxAnchorPlaceholder();

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 0.0,
      maxHeight: 0.0,
      child: ConstrainedBox(constraints: const BoxConstraints.expand()),
    );
  }
}
