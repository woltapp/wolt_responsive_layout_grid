import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

const _defaultGutter = 8.0;
const _defaultMargin = 8.0;

/// Implementation of Material Design's responsive layout grid that adapts to screen size and orientation,
/// ensuring consistency across layouts.
///
/// The grid consists of a list of [WoltColumnSpanCell] objects, which represent column-spanning cells within the grid.
/// The [gutter] specifies the spacing between columns, and the [margin] defines the margin around the grid.
/// The [isOverlayVisible] flag determines whether an overlay for debugging purposes is displayed.
///
/// For more information, please refer to the official documentation available at "https://m2.material.io/design/layout/responsive-layout-grid.html#grid-customization"
class WoltResponsiveLayoutGrid extends StatelessWidget {
  const WoltResponsiveLayoutGrid({
    super.key,
    required this.columnSpanCells,
    this.gutter = _defaultGutter,
    this.margin = _defaultMargin,
    this.isOverlayVisible = false,
  });

  /// Creates a centered layout with a child widget and specified column counts.
  ///
  /// The [child] widget represents the centered content of the grid.
  /// The [centerWidgetColumnCount] specifies the number of columns to be occupied by the centered widget.
  /// The [paddedColumnCountPerSide] represents the number of columns to be added on each side of the centered widget.
  /// The [isOverlayVisible] flag determines whether an overlay for debugging purposes is displayed.
  /// The [gutter] specifies the spacing between columns, and the [margin] defines the margin around the grid.
  /// The [margin] defines the margin around the grid.
  factory WoltResponsiveLayoutGrid.centered({
    Key? key,
    required Widget child,
    int centerWidgetColumnCount = 2,
    int paddedColumnCountPerSide = 1,
    bool isOverlayVisible = false,
    double gutter = _defaultGutter,
    double margin = _defaultMargin,
  }) {
    return WoltResponsiveLayoutGrid(
      key: key,
      isOverlayVisible: isOverlayVisible,
      columnSpanCells: [
        WoltColumnSpanCell(
          columnCellWidget: const SizedBox.expand(),
          columnSpan: paddedColumnCountPerSide,
        ),
        WoltColumnSpanCell(
          columnCellWidget: child,
          columnSpan: centerWidgetColumnCount,
        ),
        WoltColumnSpanCell(
          columnCellWidget: const SizedBox.expand(),
          columnSpan: paddedColumnCountPerSide,
        ),
      ],
      gutter: gutter,
      margin: margin,
    );
  }

  /// Represents a list of column-spanning cells within the grid.
  final List<WoltColumnSpanCell> columnSpanCells;

  /// The spacing between columns in the grid.
  final double gutter;

  /// The margin around the grid.
  final double margin;

  /// Determines whether an overlay for debugging purposes is visible.
  final bool isOverlayVisible;

  int get _indexOfLastGridContent => columnSpanCells.length - 1;

  double get _totalMarginWidth => margin * 2;

  int get _totalColumnCount => columnSpanCells.map((e) => e.columnSpan).reduce((a, b) => a + b);

  double get _totalGutterWidth => (_totalColumnCount - 1) * gutter;

  double _totalWidthWithoutGutterAndMargin(double totalWidth) =>
      totalWidth - _totalGutterWidth - _totalMarginWidth;

  double _columnWidth(double totalAvailableWidth) =>
      _totalWidthWithoutGutterAndMargin(totalAvailableWidth) / _totalColumnCount;

  double _columnSpanWidth(int columnSpan, double columnWidth) =>
      (columnWidth * columnSpan) + (gutter * (columnSpan - 1));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalAvailableWidth = constraints.maxWidth;
        final columnWidth = _columnWidth(totalAvailableWidth);
        return Stack(
          children: [
            Row(
              children: [
                _Margin(margin: margin),
                for (int i = 0; i < columnSpanCells.length; i++)
                  Row(
                    children: [
                      SizedBox(
                        width: _columnSpanWidth(columnSpanCells[i].columnSpan, columnWidth),
                        child: columnSpanCells[i].columnCellWidget,
                      ),
                      if (i != _indexOfLastGridContent) _Gutter(gutter: gutter),
                    ],
                  ),
                _Margin(margin: margin),
              ],
            ),
            if (isOverlayVisible)
              Row(
                children: [
                  _Margin(margin: margin, isOverlay: true),
                  for (int i = 0; i < _totalColumnCount; i++)
                    Row(children: [
                      _Column(columnWidth: columnWidth, isOverlay: true),
                      if (i != _totalColumnCount - 1) _Gutter(gutter: gutter, isOverlay: true),
                    ]),
                  _Margin(margin: margin, isOverlay: true),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({
    required this.columnWidth,
    this.isOverlay = false,
  });

  final double columnWidth;
  final bool isOverlay;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isOverlay ? Colors.red.withOpacity(0.2) : Colors.transparent,
      child: SizedBox(width: columnWidth, height: double.infinity),
    );
  }
}

class _Margin extends StatelessWidget {
  const _Margin({
    required this.margin,
    this.isOverlay = false,
  });

  final double margin;
  final bool isOverlay;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isOverlay ? Colors.green.withOpacity(0.2) : Colors.transparent,
      child: SizedBox(width: margin, height: double.infinity),
    );
  }
}

class _Gutter extends StatelessWidget {
  const _Gutter({
    required this.gutter,
    this.isOverlay = false,
  });

  final double gutter;
  final bool isOverlay;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isOverlay ? Colors.cyan.withOpacity(0.2) : Colors.transparent,
      child: SizedBox(width: gutter, height: double.infinity),
    );
  }
}
