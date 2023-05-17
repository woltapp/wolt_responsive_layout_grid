import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/src/wolt_responsive_layout_grid.dart';

/// Represents a column span cell within [WoltResponsiveLayoutGrid].
///
/// A column span cell is a unit within the grid that spans multiple columns.
/// It encapsulates a widget to be placed in the grid and specifies the number of columns it should occupy.
class WoltColumnSpanCell {
  /// Creates a new instance of a column span cell.
  ///
  /// The [columnCellWidget] parameter represents the widget to be placed within the column span cell.
  /// The [columnSpan] parameter specifies the number of columns that the cell should occupy in the grid.
  const WoltColumnSpanCell({
    required this.columnCellWidget,
    required this.columnSpan,
  });

  /// The widget to be placed within the column span cell.
  final Widget columnCellWidget;

  /// The number of columns that the cell should span.
  final int columnSpan;
}
