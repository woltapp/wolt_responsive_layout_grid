import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

const _defaultGutter = 8.0;
const _defaultMargin = 8.0;

/// Implementation for the Material Design’s responsive layout grid adapts to screen size and
/// orientation, ensuring consistency across layouts.
/// https://m2.material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
class WoltResponsiveLayoutGrid extends StatelessWidget {
  const WoltResponsiveLayoutGrid({
    required this.gridContentList,
    this.gutter = _defaultGutter,
    this.margin,
    this.isOverlayVisible = false,
    super.key,
  });

  factory WoltResponsiveLayoutGrid.centered({
    required Widget child,
    int centerWidgetColumnCount = 2,
    int paddedColumnCountPerSide = 1,
    bool isOverlayVisible = false,
    double? gutter,
    double? margin,
  }) {
    return WoltResponsiveLayoutGrid(
      isOverlayVisible: isOverlayVisible,
      gridContentList: [
        WoltResponsiveLayoutGridContent(
          content: SizedBox.expand(),
          columnCount: paddedColumnCountPerSide,
        ),
        WoltResponsiveLayoutGridContent(
          content: child,
          columnCount: centerWidgetColumnCount,
        ),
        WoltResponsiveLayoutGridContent(
          content: SizedBox.expand(),
          columnCount: paddedColumnCountPerSide,
        ),
      ],
      gutter: _defaultGutter,
      margin: _defaultMargin,
    );
  }

  final List<WoltResponsiveLayoutGridContent> gridContentList;
  final double gutter;
  final double? margin;
  final bool isOverlayVisible;

  double get _margin => margin ?? _defaultMargin;

  int get _indexOfLastGridContent => gridContentList.length - 1;

  int get _totalColumnCount => gridContentList.map((e) => e.columnCount).reduce((a, b) => a + b);

  double get _totalGutterWidth => (_totalColumnCount - 1) * gutter;

  double get _totalMarginWidth => _margin * 2;

  double _totalWidthWithoutGutterAndMargin(double totalWidth) =>
      totalWidth - _totalGutterWidth - _totalMarginWidth;

  double _columnWidth(double totalWidth) =>
      _totalWidthWithoutGutterAndMargin(totalWidth) / _totalColumnCount;

  double _contentWidth(int columnCount, double columnWidth) =>
      (columnWidth * columnCount) + (gutter * (columnCount - 1));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = _columnWidth(constraints.maxWidth);
        return Stack(
          children: [
            Row(
              children: [
                _Margin(margin: _margin),
                for (int i = 0; i < gridContentList.length; i++)
                  Row(
                    children: [
                      SizedBox(
                        width: _contentWidth(gridContentList[i].columnCount, columnWidth),
                        child: gridContentList[i].content,
                      ),
                      if (i != _indexOfLastGridContent) _Gutter(gutter: gutter),
                    ],
                  ),
                _Margin(margin: _margin),
              ],
            ),
            if (isOverlayVisible)
              Row(
                children: [
                  _Margin(margin: _margin, isOverlay: true),
                  for (int i = 0; i < _totalColumnCount; i++)
                    Row(children: [
                      _Column(columnWidth: columnWidth, isOverlay: true),
                      if (i != _totalColumnCount - 1) _Gutter(gutter: gutter, isOverlay: true),
                    ]),
                  _Margin(margin: _margin, isOverlay: true),
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
      child: SizedBox(width: columnWidth, height: double.infinity),
      color: isOverlay ? Colors.red.withOpacity(0.2) : Colors.transparent,
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
      child: SizedBox(width: margin, height: double.infinity),
      color: isOverlay ? Colors.green.withOpacity(0.2) : Colors.transparent,
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
      child: SizedBox(width: gutter, height: double.infinity),
      color: isOverlay ? Colors.cyan.withOpacity(0.2) : Colors.transparent,
    );
  }
}
