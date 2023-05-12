import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/src/wolt_screen_size.dart';

class WoltScreenWidthAdaptiveWidget extends StatelessWidget {
  const WoltScreenWidthAdaptiveWidget({
    required this.smallScreenWidthChild,
    required this.largeScreenWidthChild,
    this.widthBreakPoint = 768,
    super.key,
  });

  final Widget smallScreenWidthChild;
  final Widget largeScreenWidthChild;
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
