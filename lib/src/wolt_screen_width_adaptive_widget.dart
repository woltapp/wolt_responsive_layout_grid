import 'package:flutter/material.dart';

/// Defines the two possible screen sizes for the `WoltScreenWidthAdaptiveWidget`.
enum WoltScreenSize {
  /// Represents a small screen size.
  small,

  /// Represents a large screen size.
  large,
}

/// A widget that adapts its child based on the screen width.
///
/// The `WoltScreenWidthAdaptiveWidget` takes two child widgets: `smallScreenWidthChild` and `largeScreenWidthChild`.
/// The `smallScreenWidthChild` is displayed when the screen width is below the `widthBreakPoint`.
/// The `largeScreenWidthChild` is displayed when the screen width is equal to or above the `widthBreakPoint`.
///
/// By default, the `widthBreakPoint` is set to [defaultWidthBreakPoint].
class WoltScreenWidthAdaptiveWidget extends StatelessWidget {
  /// Creates a new instance of `WoltScreenWidthAdaptiveWidget`.
  ///
  /// The `smallScreenWidthChild` is displayed when the screen width is below the `widthBreakPoint`.
  /// The `largeScreenWidthChild` is displayed when the screen width is equal to or above the `widthBreakPoint`.
  /// The `widthBreakPoint` defines the screen width breakpoint to determine the adaptive behavior.
  const WoltScreenWidthAdaptiveWidget({
    required this.smallScreenWidthChild,
    required this.largeScreenWidthChild,
    this.widthBreakPoint = 768,
    Key? key,
  }) : super(key: key);

  /// The child widget to be displayed when the screen width is below the `widthBreakPoint`.
  final Widget smallScreenWidthChild;

  /// The child widget to be displayed when the screen width is equal to or above the `widthBreakPoint`.
  final Widget largeScreenWidthChild;

  /// By default, the `widthBreakPoint` is set to 768, which corresponds to the common breakpoint between small and large screens.
  static const defaultWidthBreakPoint = 768;

  /// The screen width breakpoint to determine the adaptive behavior.
  /// If the screen width is below this breakpoint, the `smallScreenWidthChild` will be displayed;
  /// otherwise, the `largeScreenWidthChild` will be displayed.
  final double widthBreakPoint;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width < widthBreakPoint
        ? WoltScreenSize.small
        : WoltScreenSize.large;

    switch (screenSize) {
      case WoltScreenSize.small:
        return smallScreenWidthChild;
      case WoltScreenSize.large:
        return largeScreenWidthChild;
    }
  }
}