import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AnimatedOverlay extends ImplicitlyAnimatedWidget {
  const AnimatedOverlay({
    super.key,
    super.curve,
    super.duration = const Duration(milliseconds: 100),
    this.color,
    this.opacity,
    this.radius,
    this.borderRadius,
    this.shape,
    this.child,
  });

  final Color? color;
  final double? opacity;
  final double? radius;
  final BorderRadius? borderRadius;
  final BoxShape? shape;
  final Widget? child;

  @override
  AnimatedWidgetBaseState<AnimatedOverlay> createState() =>
      _AnimatedOverlayState();
}

class _AnimatedOverlayState extends AnimatedWidgetBaseState<AnimatedOverlay> {
  ColorTween? colorTween;
  Tween<double?>? opacityTween;
  Tween<double?>? radiusTween;
  BorderRadiusTween? borderRadiusTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    colorTween = visitor(
      colorTween,
      widget.color,
      (dynamic value) => ColorTween(begin: value),
    ) as ColorTween?;

    opacityTween = visitor(
      opacityTween,
      widget.opacity,
      (dynamic value) => Tween<double?>(begin: value),
    ) as Tween<double?>?;

    radiusTween = visitor(
      radiusTween,
      widget.radius,
      (dynamic value) => Tween<double?>(begin: value),
    ) as Tween<double?>?;

    borderRadiusTween = visitor(
      borderRadiusTween,
      widget.borderRadius,
      (dynamic value) => BorderRadiusTween(begin: value),
    ) as BorderRadiusTween?;
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      color: colorTween?.evaluate(animation),
      opacity: opacityTween?.evaluate(animation),
      radius: radiusTween?.evaluate(animation),
      borderRadius: borderRadiusTween?.evaluate(animation),
      shape: widget.shape,
      child: widget.child,
    );
  }
}

class Overlay extends SingleChildRenderObjectWidget {
  const Overlay({
    super.key,
    this.color,
    this.opacity,
    this.radius,
    this.borderRadius,
    this.shape,
    super.child,
  });

  final Color? color;
  final double? opacity;
  final double? radius;
  final BorderRadius? borderRadius;
  final BoxShape? shape;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderOverlay(
      color: color,
      opacity: opacity,
      radius: radius,
      borderRadius: borderRadius,
      shape: shape,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderOverlay renderObject,
  ) {
    renderObject
      ..color = color
      ..opacity = opacity
      ..radius = radius
      ..borderRadius = borderRadius
      ..shape = shape;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('opacity', opacity));
    properties.add(DoubleProperty('radius', radius));
    properties
        .add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius));
    properties.add(EnumProperty<BoxShape?>('shape', shape));
  }
}

class RenderOverlay extends RenderProxyBox {
  RenderOverlay({
    Color? color,
    double? opacity,
    BoxShape? shape,
    double? radius,
    BorderRadius? borderRadius,
  })  : _color = color ?? const Color(0xFF000000),
        _opacity = opacity ?? 0.0,
        _shape = shape ?? BoxShape.circle,
        _radius = radius,
        _borderRadius = borderRadius ?? BorderRadius.zero;

  @override
  bool get isRepaintBoundary => true;

  Color get color => _color;
  Color _color;
  set color(Color? value) {
    if (value == null) return;
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  double get opacity => _opacity;
  double _opacity;
  set opacity(double? value) {
    if (value == null) return;
    if (_opacity == value) return;
    _opacity = value;
    markNeedsPaint();
  }

  BoxShape get shape => _shape;
  BoxShape _shape;
  set shape(BoxShape? value) {
    if (value == null) return;
    if (_shape == value) return;
    _shape = value;
    markNeedsPaint();
  }

  double get radius => _radius ?? size.shortestSide;
  double? _radius;
  set radius(double? value) {
    if (value == null) return;
    if (_radius == value) return;
    _radius = value;
    markNeedsPaint();
  }

  BorderRadius get borderRadius => _borderRadius;
  BorderRadius _borderRadius;
  set borderRadius(BorderRadius? value) {
    if (value == null) return;
    if (_borderRadius == value) return;
    _borderRadius = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    final Canvas canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final paint = Paint()..color = color.withOpacity(opacity);
    final rect = Offset.zero & size;
    if (shape == BoxShape.rectangle) {
      if (borderRadius != BorderRadius.zero) {
        canvas.drawRRect(borderRadius.toRRect(rect), paint);
      } else {
        canvas.drawRect(rect, paint);
      }
    } else {
      canvas.drawCircle(rect.center, radius, paint);
    }

    canvas.restore();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('opacity', opacity));
    properties.add(EnumProperty<BoxShape>('shape', shape));
    properties.add(DoubleProperty('radius', radius));
    properties
        .add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius));
  }
}
