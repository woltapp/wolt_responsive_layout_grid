import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/src/utils/responsive_layout_grid_utils.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

const _defaultGutter = 8.0;
const _defaultMargin = EdgeInsets.symmetric(horizontal: 8);

/// Implementation for the Material Design’s responsive layout grid adapts to screen size and
/// orientation, ensuring consistency across layouts.
/// https://m2.material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
class WoltResponsiveLayoutGrid extends StatelessWidget {
  const WoltResponsiveLayoutGrid({
    required this.gridContentGroup,
    this.gutter = _defaultGutter,
    this.margin,
    super.key,
  });

  factory WoltResponsiveLayoutGrid.centered({
    required Widget child,
    int centerWidgetColumnCount = 1,
    int horizontalPaddedColumnCount = 1,
    double? gutter,
    EdgeInsetsGeometry? margin,
  }) {
    return WoltResponsiveLayoutGrid(
      gridContentGroup: [
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
      margin: margin,
    );
  }

  final List<WoltResponsiveLayoutGridContent> gridContentGroup;

  final double gutter;

  final EdgeInsetsGeometry? margin;

  int get indexOfLastContent => gridContentGroup.length - 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? _defaultMargin,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              for (int i = 0; i < gridContentGroup.length; i++)
                Row(
                  children: [
                    SizedBox(
                      width: ResponsiveUiUtils.calculateWidthForGridContent(
                        gridContentList: gridContentGroup,
                        groupIndex: i,
                        gutter: gutter,
                        totalWidth: constraints.maxWidth,
                      ),
                      child: gridContentGroup[i].content,
                    ),
                    if (i != indexOfLastContent) SizedBox(width: gutter),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
