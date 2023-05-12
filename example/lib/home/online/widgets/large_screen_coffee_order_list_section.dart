import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid_example/constants/demo_app_constants.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/coffee_order_list_widget.dart';

class LargeScreenCoffeeOrderListSection extends StatelessWidget {
  const LargeScreenCoffeeOrderListSection({
    required this.coffeeOrderListWidget,
    required this.coffeeMakerStep,
    super.key,
  });

  final CoffeeOrderListWidget coffeeOrderListWidget;
  final CoffeeMakerStep coffeeMakerStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LargeScreenCoffeeOrderListHeader(
          coffeeMakerStep: coffeeMakerStep,
          count: coffeeOrderListWidget.coffeeOrders.length,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: coffeeMakerStep == CoffeeMakerStep.ready ? DemoAppColors.white : null,
            decoration: coffeeMakerStep == CoffeeMakerStep.ready
                ? null
                : ShapeDecoration(
                    color: DemoAppColors.black4,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: DemoAppColors.white, width: 2),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      ),
                    ),
                  ),
            child: coffeeOrderListWidget,
          ),
        ),
      ],
    );
  }
}

class _LargeScreenCoffeeOrderListHeader extends StatelessWidget {
  const _LargeScreenCoffeeOrderListHeader({required this.coffeeMakerStep, required this.count});

  final CoffeeMakerStep coffeeMakerStep;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: EdgeInsets.only(top: 16, bottom: 8),
      decoration: ShapeDecoration(
        shape: StadiumBorder(side: BorderSide(color: DemoAppColors.gray, width: 2)),
        color: DemoAppColors.white,
      ),
      child: Text(
        '${coffeeMakerStep.stepName} ($count)',
        style: Theme.of(context).textTheme.titleMedium!,
        textAlign: TextAlign.center,
      ),
    );
  }
}
