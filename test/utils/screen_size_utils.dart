// ignore_for_file: deprecated_member_use
// TODO: Refactor to update deprecated APIs.

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

/// Helper method to set the test screen width for widget testing.
///
/// The `setTestScreenWidth` method adjusts the device pixel ratio and physical size of the test window
/// to simulate a specific screen width during widget testing.
///
/// The `width` parameter represents the desired screen width in logical pixels.
/// It is multiplied by the device pixel ratio to calculate the physical size of the test window.
///
/// Note: The device pixel ratio is set to a magic number of 2.625, which is commonly used for testing on high-density displays.
/// This value ensures that the logical pixel width matches the desired screen width accurately.
///
/// Usage:
/// ```dart
/// setTestScreenWidth(tester, 360);
/// ```
void setTestScreenWidth(WidgetTester tester, double width) {
  // Magic number for device pixel ratio: https://stackoverflow.com/a/62460566
  tester.binding.window.devicePixelRatioTestValue = 2.625;
  final dpi = tester.binding.window.devicePixelRatio;
  tester.binding.window.physicalSizeTestValue = Size(width * dpi, 812 * dpi);
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
}
