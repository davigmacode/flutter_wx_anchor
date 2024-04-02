import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Provides platform-specific acoustic and/or haptic feedback for certain
/// actions.
///
/// For example, to play the Android-typically click sound when a button is
/// tapped, call [forTap]. For the Android-specific vibration when long pressing
/// an element, call [forLongPress].
///
/// Calling any of these methods is a no-op on iOS as actions on that platform
/// typically don't provide haptic or acoustic feedback.
///
/// All methods in this class are usually called from within a
/// [StatelessWidget.build] method or from a [State]'s methods as you have to
/// provide a [BuildContext].
///
/// To trigger platform-specific feedback before executing the actual callback:
///
/// ```dart
/// class WidgetWithExplicitCall extends StatelessWidget {
///   const WidgetWithExplicitCall({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return GestureDetector(
///       onTap: () {
///         // Do some work (e.g. check if the tap is valid)
///         Feedback.forTap(context);
///         // Do more work (e.g. respond to the tap)
///       },
///       onLongPress: () {
///         // Do some work (e.g. check if the long press is valid)
///         Feedback.forLongPress(context);
///         // Do more work (e.g. respond to the long press)
///       },
///       child: const Text('X'),
///     );
///   }
/// }
/// ```
abstract final class Feedback {
  /// Provides platform-specific feedback for a tap.
  ///
  /// On Android the click system sound is played. On iOS this is a no-op.
  static Future<void> forTap(
    BuildContext context,
    TargetPlatform platform,
  ) async {
    context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return SystemSound.play(SystemSoundType.click);
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Future<void>.value();
    }
  }

  /// Provides platform-specific feedback for a long press.
  ///
  /// On Android the platform-typical vibration is triggered. On iOS this is a
  /// no-op as that platform usually doesn't provide feedback for long presses.
  static Future<void> forLongPress(
    BuildContext context,
    TargetPlatform platform,
  ) {
    context
        .findRenderObject()!
        .sendSemanticsEvent(const LongPressSemanticsEvent());
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return HapticFeedback.vibrate();
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Future<void>.value();
    }
  }
}
