import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_order.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/coffee_order_list_item_tile.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/empty_coffee_order_list_widget.dart';

class CoffeeOrderListWidget extends StatelessWidget {
  const CoffeeOrderListWidget({
    required this.coffeeOrders,
    required this.coffeeMakerStep,
    required this.onCoffeeOrderSelected,
    super.key,
  });

  final CoffeeMakerStep coffeeMakerStep;
  final List<CoffeeOrder> coffeeOrders;
  final ValueChanged<String> onCoffeeOrderSelected;

  @override
  Widget build(BuildContext context) {
    return coffeeOrders.isEmpty
        ? EmptyCoffeeOrderList(coffeeMakerStep: coffeeMakerStep)
        : ListView.separated(
            itemBuilder: (_, index) {
              final coffeeOrder = coffeeOrders[index];
              return Column(
                children: [
                  if (index == 0) SizedBox(height: 16),
                  CoffeeOrderListItemTile(
                    coffeeOrder: coffeeOrder,
                    onSelected: onCoffeeOrderSelected,
                  ),
                  if (index == coffeeOrders.length - 1) SizedBox(height: 16),
                ],
              );
            },
            itemCount: coffeeOrders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
          );
  }
}
