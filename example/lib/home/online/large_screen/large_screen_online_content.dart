import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/large_screen/large_screen_coffee_order_list_section.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/coffee_order_list_widget.dart';
import 'package:wolt_responsive_layout_grid_example/home/widgets/wolt_top_bar.dart';

class LargeScreenOnlineContent extends StatefulWidget {
  const LargeScreenOnlineContent({
    required this.coffeeMakerStepListWidgets,
    required this.isStoreOnlineNotifier,
  });

  final Map<CoffeeMakerStep, CoffeeOrderListWidget> coffeeMakerStepListWidgets;
  final ValueNotifier<bool> isStoreOnlineNotifier;

  @override
  State<LargeScreenOnlineContent> createState() => _LargeScreenOnlineContentState();
}

class _LargeScreenOnlineContentState extends State<LargeScreenOnlineContent> {
  bool _isOverlayVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() => _isOverlayVisible = !_isOverlayVisible);
              },
              child: WoltTopBar(isStoreOnlineNotifier: widget.isStoreOnlineNotifier),
            ),
            Expanded(
              child: WoltResponsiveLayoutGrid(
                margin: 8,
                gutter: 8,
                isOverlayVisible: _isOverlayVisible,
                columnSpanCells: [
                  WoltColumnSpanCell(
                    columnSpan: 3,
                    columnCellWidget: LargeScreenCoffeeOrderListSection(
                      coffeeMakerStep: CoffeeMakerStep.grind,
                      coffeeOrderListWidget:
                          widget.coffeeMakerStepListWidgets[CoffeeMakerStep.grind]!,
                    ),
                  ),
                  WoltColumnSpanCell(
                    columnSpan: 3,
                    columnCellWidget: LargeScreenCoffeeOrderListSection(
                      coffeeMakerStep: CoffeeMakerStep.addWater,
                      coffeeOrderListWidget:
                          widget.coffeeMakerStepListWidgets[CoffeeMakerStep.addWater]!,
                    ),
                  ),
                  WoltColumnSpanCell(
                    columnSpan: 2,
                    columnCellWidget: LargeScreenCoffeeOrderListSection(
                      coffeeMakerStep: CoffeeMakerStep.ready,
                      coffeeOrderListWidget:
                          widget.coffeeMakerStepListWidgets[CoffeeMakerStep.ready]!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
