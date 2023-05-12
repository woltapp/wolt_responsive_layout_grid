import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';

class EmptyCoffeeOrderList extends StatelessWidget {
  const EmptyCoffeeOrderList({
    required this.coffeeMakerStep,
    super.key,
  });

  final CoffeeMakerStep coffeeMakerStep;

  @override
  Widget build(BuildContext context) {
    return WoltScreenWidthAdaptiveWidget(
      largeScreenWidthChild: SizedBox.shrink(),
      smallScreenWidthChild: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              coffeeMakerStep.stepName,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              'New tasks will appear here automatically',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

extension CoffeeMakerStepExtension on CoffeeMakerStep {
  String get title {
    switch (this) {
      case CoffeeMakerStep.grind:
        return 'No need to grind';
      case CoffeeMakerStep.addWater:
        return 'No need to addWater';
      case CoffeeMakerStep.ready:
        return 'Nothing ready yet';
    }
  }
}
