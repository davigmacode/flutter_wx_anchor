import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnimatedOverlay extends ImplicitlyAnimatedWidget {
  const AnimatedOverlay({
    super.key,
    super.curve,
    super.duration = const Duration(milliseconds: 100),
    this.color,
    this.opacity,
    this.shape,
    this.extent,
    this.child,
  });

  final Color? color;
  final double? opacity;
  final ShapeBorder? shape;
  final Size? extent;
  final Widget? child;

  @override
  AnimatedWidgetBaseState<AnimatedOverlay> createState() =>
      _AnimatedOverlayState();
}

class _AnimatedOverlayState extends AnimatedWidgetBaseState<AnimatedOverlay> {
  ColorTween? colorTween;
  Tween<double?>? opacityTween;
  ShapeBorderTween? shapeTween;
  SizeTween? extentTween;

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

    shapeTween = visitor(
      shapeTween,
      widget.shape,
      (dynamic value) => ShapeBorderTween(begin: value),
    ) as ShapeBorderTween?;

    extentTween = visitor(
      extentTween,
      widget.extent,
      (dynamic value) => SizeTween(begin: value),
    ) as SizeTween?;
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      color: colorTween?.evaluate(animation),
      opacity: opacityTween?.evaluate(animation),
      shape: shapeTween?.evaluate(animation),
      extent: extentTween?.evaluate(animation),
      child: widget.child,
    );
  }
}

class Overlay extends SingleChildRenderObjectWidget {
  const Overlay({
    super.key,
    this.color,
    this.opacity,
    this.shape,
    this.extent,
    super.child,
  });

  final Color? color;
  final double? opacity;
  final ShapeBorder? shape;
  final Size? extent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderOverlay(
      color: color,
      opacity: opacity,
      shape: shape,
      extent: extent,
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
      ..shape = shape
      ..extent = extent;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('opacity', opacity));
    properties.add(DiagnosticsProperty('shape', shape));
    properties.add(DiagnosticsProperty('extent', extent));
  }
}

class RenderOverlay extends RenderProxyBox {
  RenderOverlay({
    Color? color,
    double? opacity,
    ShapeBorder? shape,
    Size? extent,
  })  : _color = color ?? const Color(0xFF000000),
        _opacity = opacity ?? 0.0,
        _shape = shape ?? const RoundedRectangleBorder(),
        _extent = extent;

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

  ShapeBorder get shape => _shape;
  ShapeBorder _shape;
  set shape(ShapeBorder? value) {
    if (value == null) return;
    if (_shape == value) return;
    _shape = value;
    markNeedsPaint();
  }

  Size get extent => _extent ?? size;
  Size? _extent;
  set extent(Size? value) {
    if (value == null) return;
    if (_extent == value) return;
    _extent = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    final Canvas canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final paint = Paint()..color = color.withOpacity(opacity);
    final origin = Offset.zero & size;
    final rect = Rect.fromCenter(
      center: origin.center,
      width: extent.width,
      height: extent.height,
    );

    if (shape.preferPaintInterior) {
      shape.paintInterior(canvas, rect, paint);
    } else {
      final path = shape.getOuterPath(rect);
      canvas.drawPath(path, paint);
    }
    canvas.restore();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('opacity', opacity));
    properties.add(DiagnosticsProperty('shape', shape));
    properties.add(DiagnosticsProperty('extent', extent));
  }
}
