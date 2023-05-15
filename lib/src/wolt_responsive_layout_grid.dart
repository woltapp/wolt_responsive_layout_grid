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
    int centerWidgetColumnCount = 1,
    int horizontalPaddedColumnCount = 1,
    bool isOverlayVisible = false,
    double? gutter,
    double? margin,
  }) {
    return WoltResponsiveLayoutGrid(
      isOverlayVisible: isOverlayVisible,
      gridContentList: [
        WoltResponsiveLayoutGridContent(
          content: SizedBox.expand(),
          columnCount: horizontalPaddedColumnCount,
        ),
        WoltResponsiveLayoutGridContent(content: child, columnCount: centerWidgetColumnCount),
        WoltResponsiveLayoutGridContent(
          content: SizedBox.expand(),
          columnCount: horizontalPaddedColumnCount,
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

  int get indexOfLastGridContent => gridContentList.length - 1;

  @override
  Widget build(BuildContext context) {
    final margin = this.margin ?? _defaultMargin;
    return LayoutBuilder(
      builder: (context, constraints) {
        final measurementData = _LayoutData(
          totalWidth: constraints.maxWidth,
          gutter: gutter,
          margin: margin,
          gridContentList: gridContentList,
        );
        final widthPerColumn = measurementData.columnWidth;
        return Stack(
          children: [
            Row(
              children: [
                _Margin(margin: margin),
                for (int i = 0; i < gridContentList.length; i++)
                  Row(
                    children: [
                      SizedBox(
                        width: (widthPerColumn * gridContentList[i].columnCount) +
                            (gutter * (gridContentList[i].columnCount - 1)),
                        child: gridContentList[i].content,
                      ),
                      if (i != indexOfLastGridContent) _Gutter(gutter: gutter),
                    ],
                  ),
                _Margin(margin: margin),
              ],
            ),
            if (isOverlayVisible)
              _WoltResponsiveLayoutGridColoredOverlay(layoutData: measurementData),
          ],
        );
      },
    );
  }
}

class _LayoutData {
  const _LayoutData({
    required this.totalWidth,
    required this.gutter,
    required this.margin,
    required this.gridContentList,
  });

  final double totalWidth;
  final double gutter;
  final double margin;
  final List<WoltResponsiveLayoutGridContent> gridContentList;

  int get totalColumnCount => gridContentList.map((e) => e.columnCount).reduce((a, b) => a + b);

  double get totalGutterWidth => (totalColumnCount - 1) * gutter;

  double get totalMarginWidth => margin * 2;

  double get totalWidthWithoutGutterAndMargin => totalWidth - totalGutterWidth - totalMarginWidth;

  double get columnWidth => totalWidthWithoutGutterAndMargin / totalColumnCount;
}

class _WoltResponsiveLayoutGridColoredOverlay extends StatelessWidget {
  const _WoltResponsiveLayoutGridColoredOverlay({required this.layoutData});

  final _LayoutData layoutData;

  @override
  Widget build(BuildContext context) {
    final totalColumnCount = layoutData.totalColumnCount;
    return Row(
      children: [
        _Margin(margin: layoutData.margin, isOverlay: true),
        for (int i = 0; i < totalColumnCount; i++)
          Row(children: [
            _Column(columnWidth: layoutData.columnWidth, isOverlay: true),
            if (i != totalColumnCount - 1) _Gutter(gutter: layoutData.gutter, isOverlay: true),
          ]),
        _Margin(margin: layoutData.margin, isOverlay: true),
      ],
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
    return Container(
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
    return Container(
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
    return Container(
      width: gutter,
      height: double.infinity,
      color: isOverlay ? Colors.cyan.withOpacity(0.2) : Colors.transparent,
    );
  }
}
