import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid_example/constants/demo_app_constants.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_order.dart';

class CoffeeOrderListItemTile extends StatelessWidget {
  const CoffeeOrderListItemTile({
    required this.coffeeOrder,
    required this.onSelected,
    super.key,
  });

  final CoffeeOrder coffeeOrder;
  final ValueChanged<String> onSelected;

  VoidCallback get onTap => () {
        print("Selected coffee order: ${coffeeOrder.id}");
        onSelected(coffeeOrder.id);
      };

  @override
  Widget build(BuildContext context) {
    final step = coffeeOrder.coffeeMakerStep;
    return SizedBox(
      height: 180,
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Image(image: AssetImage(step.assetName), fit: BoxFit.cover, width: double.infinity),
                Container(color: DemoAppColors.black.withOpacity(0.3)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _CoffeeOrderListItemDetails(
                        coffeeOrder: coffeeOrder,
                        onTap: onTap,
                      ),
                      Spacer(),
                      SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          child: Center(child: Text(step.actionName)),
                          onPressed: onTap,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CoffeeOrderListItemDetails extends StatelessWidget {
  const _CoffeeOrderListItemDetails({
    required this.coffeeOrder,
    required this.onTap,
  });

  final CoffeeOrder coffeeOrder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: onTap,
          child: Text(
            coffeeOrder.id,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            coffeeOrder.orderName,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: DemoAppColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
