import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

extension BuiltContextExtensionForWoltScreenSize on BuildContext {
  WoltScreenSize get screenSize =>
      MediaQuery.of(this).size.width < 768 ? WoltScreenSize.small : WoltScreenSize.large;
}
