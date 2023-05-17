import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolt_responsive_layout_grid/src/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid/src/wolt_column_span_cell.dart';

void main() {
  group('calculateColumnGroupWidthInResponsiveLayoutGrid', () {
    const gutter = 8.0;
    const margin = 8.0;
    const firstGridContentKey = Key('firstGridContent');
    const secondGridContentKey = Key('secondGridContent');
    const thirdGridContentKey = Key('thirdGridContent');

    void setWoltScreenSize(WidgetTester tester, double width) {
      // Magic number for device pixel ratio: https://stackoverflow.com/a/62460566
      tester.binding.window.devicePixelRatioTestValue = 2.625;
      final dpi = tester.binding.window.devicePixelRatio;
      tester.binding.window.physicalSizeTestValue = Size(width * dpi, 812 * dpi);
    }

    testWidgets('3:3:2 layout with gutter for 3-column group', (tester) async {
      const List<WoltColumnSpanCell> gridContentList = [
        WoltColumnSpanCell(
          columnSpan: 3,
          columnCellWidget: Placeholder(key: firstGridContentKey),
        ),
        WoltColumnSpanCell(
          columnSpan: 3,
          columnCellWidget: Placeholder(key: secondGridContentKey),
        ),
        WoltColumnSpanCell(
          columnSpan: 2,
          columnCellWidget: Placeholder(key: thirdGridContentKey),
        ),
      ];
      setWoltScreenSize(tester, 768);
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: WoltResponsiveLayoutGrid(
              gutter: gutter,
              columnSpanCells: gridContentList,
              margin: margin,
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byKey(firstGridContentKey)).width, 277.0);
      expect(tester.getSize(find.byKey(thirdGridContentKey)).width, 182.0);
    });

    testWidgets('Centered layout with gutter for 3-column group', (tester) async {
      setWoltScreenSize(tester, 1024);
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: WoltResponsiveLayoutGrid.centered(
              child: Placeholder(key: secondGridContentKey),
              centerWidgetColumnCount: 2,
              paddedColumnCountPerSide: 1,
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byKey(secondGridContentKey)).width, 500.0);
    });
  });
}
