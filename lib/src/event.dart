import 'package:widget_event/widget_event.dart';

/// Interactive events that [WxAnchor] can take on
/// when receiving input from the user.
class WxAnchorEvent extends WidgetEvent {
  const WxAnchorEvent(super.value);

  /// The state when this widget is disabled and cannot be interacted with.
  static const disabled = WidgetEvent.disabled;

  /// The state when the user navigates with the keyboard to a given widget.
  static const focused = WidgetEvent.focused;

  /// The state when the user drags their mouse cursor over the given widget.
  static const hovered = WidgetEvent.hovered;

  /// The state when the user is actively pressing down on the given widget.
  static const pressed = WidgetEvent.pressed;

  /// Checker for whether events considers [WxAnchorEvent.disabled] to be active.
  static bool isDisabled(Set<WidgetEvent> events) {
    return events.contains(disabled);
  }

  /// Checker for whether events considers [WxAnchorEvent.focused] to be active.
  static bool isFocused(Set<WidgetEvent> events) {
    return events.contains(focused);
  }

  /// Checker for whether events considers [WxAnchorEvent.hovered] to be active.
  static bool isHovered(Set<WidgetEvent> events) {
    return events.contains(hovered);
  }

  /// Checker for whether events considers [WxAnchorEvent.pressed] to be active.
  static bool isPressed(Set<WidgetEvent> events) {
    return events.contains(pressed);
  }
}

/// Manages a set of [WxAnchorEvent]s and notifies listeners of changes.
///
/// Used by widgets that expose their internal event
/// for the sake of extensions that add support for additional events.
///
/// The controller's value is its current set of events.
/// Listeners are notified whenever the value changes.
/// The value should only be changed with update;
/// it should not be modified directly.
class WxAnchorEventController extends WidgetEventController {}

/// Set of WidgetEvent
typedef WxAnchorEvents = WidgetEvents;
