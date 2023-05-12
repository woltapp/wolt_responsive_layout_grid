import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

class ResponsiveUiUtils {
  ResponsiveUiUtils._();

  static double calculateWidthForGridContent({
    required List<WoltResponsiveLayoutGridContent> gridContentList,
    required int groupIndex,
    required double gutter,
    required double totalWidth,
  }) {
    final columnCountList = gridContentList.map((e) => e.columnCount);
    final int totalColumnCount = columnCountList.reduce((a, b) => a + b);
    if (totalColumnCount == 0) {
      return 0;
    }
    final totalGutter = (totalColumnCount - 1) * gutter;
    final widthPerColumn = (totalWidth - totalGutter) / totalColumnCount;
    final columnCountInGridContent = gridContentList[groupIndex].columnCount;
    return (columnCountInGridContent * widthPerColumn) + (columnCountInGridContent - 1) * gutter;
  }

  /// Calculates the width of an area represented with given number of columns
  /// ([columnCountInArea]) in a responsive grid layout.
  static double calculateWidthInResponsiveGridLayout({
    required int totalColumnCount,
    required double gutter,
    required double totalWidth,
    required int columnCountInArea,
  }) {
    if (totalColumnCount == 0 || columnCountInArea == 0) {
      return 0;
    }
    final totalGutter = (totalColumnCount - 1) * gutter;
    final widthPerColumn = (totalWidth - totalGutter) / totalColumnCount;
    return (columnCountInArea * widthPerColumn) + (columnCountInArea - 1) * gutter;
  }
}