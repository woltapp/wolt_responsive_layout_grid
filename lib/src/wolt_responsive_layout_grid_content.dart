import 'package:flutter/material.dart';

class WoltResponsiveLayoutGridContent {
  const WoltResponsiveLayoutGridContent({
    required this.content,
    required this.columnCount,
  });

  final Widget content;
  final int columnCount;
}