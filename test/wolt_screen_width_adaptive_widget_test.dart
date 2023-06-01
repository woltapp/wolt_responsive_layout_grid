import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';

import 'utils/screen_size_utils.dart';

void main() {
  testWidgets(
      'WoltScreenWidthAdaptiveWidget displays small screen child when width is below breakpoint',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: WoltScreenWidthAdaptiveWidget(
              smallScreenWidthChild: Text('Small Screen Child'),
              largeScreenWidthChild: Text('Large Screen Child'),
            ),
          ),
        ),
      ),
    );

    // Set the screen width below the breakpoint
    setTestScreenWidth(tester, 300);

    await tester.pump();

    expect(find.text('Small Screen Child'), findsOneWidget);
    expect(find.text('Large Screen Child'), findsNothing);
  });

  testWidgets(
      'WoltScreenWidthAdaptiveWidget displays large screen child when width is equal to or above breakpoint',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: WoltScreenWidthAdaptiveWidget(
              smallScreenWidthChild: Text('Small Screen Child'),
              largeScreenWidthChild: Text('Large Screen Child'),
            ),
          ),
        ),
      ),
    );

    // Set the screen width equal to or above the breakpoint
    // Set the screen width below the breakpoint
    setTestScreenWidth(tester, 800);

    await tester.pump();

    expect(find.text('Small Screen Child'), findsNothing);
    expect(find.text('Large Screen Child'), findsOneWidget);
  });
}
