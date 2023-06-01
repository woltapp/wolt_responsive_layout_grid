import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolt_responsive_layout_grid/src/wolt_column_span_cell.dart';
import 'package:wolt_responsive_layout_grid/src/wolt_responsive_layout_grid.dart';

import 'utils/screen_size_utils.dart';

void main() {
  group('calculateColumnGroupWidthInResponsiveLayoutGrid', () {
    const gutter = 8.0;
    const margin = 8.0;
    const firstGridContentKey = Key('firstGridContent');
    const secondGridContentKey = Key('secondGridContent');
    const thirdGridContentKey = Key('thirdGridContent');

    testWidgets('3:3:2 layout with gutter for 3-column group', (tester) async {
      const List<WoltColumnSpanCell> columnSpanCells = [
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
      setTestScreenWidth(tester, 768);
      await tester.pumpWidget(const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: WoltResponsiveLayoutGrid(
              gutter: gutter,
              columnSpanCells: columnSpanCells,
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
      setTestScreenWidth(tester, 1024);
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: WoltResponsiveLayoutGrid.centered(
              centerWidgetColumnCount: 2,
              paddedColumnCountPerSide: 1,
              child: const Placeholder(key: secondGridContentKey),
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byKey(secondGridContentKey)).width, 500.0);
    });
  });
}
