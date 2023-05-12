import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:wolt_responsive_layout_grid/src/utils/responsive_layout_grid_utils.dart';
import 'package:wolt_responsive_layout_grid/src/wolt_responsive_layout_grid_content.dart';

void main() {
  group('calculateColumnGroupWidthInResponsiveLayoutGrid', () {
    const gutter = 8.0;
    const availableWidth = 752.0;
    const List<WoltResponsiveLayoutGridContent> gridContentList = [
      WoltResponsiveLayoutGridContent(columnCount:3, content: SizedBox.shrink()),
      WoltResponsiveLayoutGridContent(columnCount:3, content: SizedBox.shrink()),
      WoltResponsiveLayoutGridContent(columnCount:2, content: SizedBox.shrink()),
    ];

    test('3:3:2 layout with gutter for 3-column group', () {
      expect(
        ResponsiveUiUtils.calculateWidthForGridContent(
          gutter: gutter,
          totalWidth: availableWidth,
          gridContentList: gridContentList,
          groupIndex: 0,
        ),
        277.0,
      );
    });

    test('3:3:2 layout with gutter for 2-column group', () {
      expect(
        ResponsiveUiUtils.calculateWidthForGridContent(
          gutter: gutter,
          totalWidth: availableWidth,
          gridContentList: gridContentList,
          groupIndex: 2,
        ),
        182.0,
      );
    });

    test('return zero if the total column count is zero', () {
      expect(
        ResponsiveUiUtils.calculateWidthForGridContent(
          gutter: gutter,
          totalWidth: availableWidth,
          gridContentList: const [
            WoltResponsiveLayoutGridContent(columnCount:0, content: SizedBox.shrink()),
            WoltResponsiveLayoutGridContent(columnCount:0, content: SizedBox.shrink()),
            WoltResponsiveLayoutGridContent(columnCount:0, content: SizedBox.shrink()),
          ],
          groupIndex: 2,
        ),
        0,
      );
    });
  });

  group('calculateWidthInResponsiveGridLayout', () {
    const gutter = 8.0;
    const availableWidth = 752.0;

    test('3:3:2 layout with gutter for 3-column group', () {
      expect(
        ResponsiveUiUtils.calculateWidthInResponsiveGridLayout(
          gutter: gutter,
          totalWidth: availableWidth,
          totalColumnCount: 8,
          columnCountInArea: 3,
        ),
        277.0,
      );
    });

    test('3:3:2 layout with gutter for 2-column group', () {
      expect(
        ResponsiveUiUtils.calculateWidthInResponsiveGridLayout(
          gutter: gutter,
          totalWidth: availableWidth,
          totalColumnCount: 8,
          columnCountInArea: 2,
        ),
        182.0,
      );
    });

    test('return zero if the columnCountInArea is zero', () {
      expect(
        ResponsiveUiUtils.calculateWidthInResponsiveGridLayout(
          gutter: gutter,
          totalWidth: availableWidth,
          totalColumnCount: 0,
          columnCountInArea: 4,
        ),
        0.0,
      );
    });

    test('return zero if the totalColumnCount is zero', () {
      expect(
        ResponsiveUiUtils.calculateWidthInResponsiveGridLayout(
          gutter: gutter,
          totalWidth: availableWidth,
          totalColumnCount: 4,
          columnCountInArea: 0,
        ),
        0.0,
      );
    });
  });
}
