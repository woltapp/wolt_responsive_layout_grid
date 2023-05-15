import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_order.dart';
import 'package:wolt_responsive_layout_grid_example/entities/grouped_coffee_orders.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/large_screen/large_screen_online_content.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/small_screen/small_screen_online_content.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/coffee_order_list_widget.dart';

typedef OnCoffeeOrderStatusChange = Function(String coffeeOrderId, [CoffeeMakerStep? newStep]);

class StoreOnlineContent extends StatefulWidget {
  const StoreOnlineContent({
    required this.groupedCoffeeOrders,
    required this.isStoreOnlineNotifier,
    super.key,
  });

  final GroupedCoffeeOrders groupedCoffeeOrders;
  final ValueNotifier<bool> isStoreOnlineNotifier;

  @override
  State<StoreOnlineContent> createState() => _StoreOnlineContentState();
}

class _StoreOnlineContentState extends State<StoreOnlineContent> {
  late GroupedCoffeeOrders _orders;

  initState() {
    super.initState();
    _orders = widget.groupedCoffeeOrders;
  }

  Map<CoffeeMakerStep, CoffeeOrderListWidget> get _coffeeMakerStepListWidgets => {
        CoffeeMakerStep.grind: CoffeeOrderListWidget(
          coffeeOrders: _orders.grindStateOrders,
          coffeeMakerStep: CoffeeMakerStep.grind,
          onCoffeeOrderSelected: (coffeeOrderId) {
            _onCoffeeOrderStatusChange(coffeeOrderId, CoffeeMakerStep.addWater);
          },
        ),
        CoffeeMakerStep.addWater: CoffeeOrderListWidget(
          coffeeOrders: _orders.addWaterStateOrders,
          coffeeMakerStep: CoffeeMakerStep.addWater,
          onCoffeeOrderSelected: (coffeeOrderId) {
            _onCoffeeOrderStatusChange(coffeeOrderId, CoffeeMakerStep.ready);
          },
        ),
        CoffeeMakerStep.ready: CoffeeOrderListWidget(
          coffeeOrders: _orders.readyStateOrders,
          coffeeMakerStep: CoffeeMakerStep.ready,
          onCoffeeOrderSelected: _onCoffeeOrderStatusChange,
        ),
      };

  @override
  Widget build(BuildContext context) {
    return WoltScreenWidthAdaptiveWidget(
      smallScreenWidthChild: SmallScreenOnlineContent(
        isStoreOnlineNotifier: widget.isStoreOnlineNotifier,
        coffeeMakerStepListWidgets: _coffeeMakerStepListWidgets,
        groupedCoffeeOrders: _orders,
      ),
      largeScreenWidthChild: LargeScreenOnlineContent(
        isStoreOnlineNotifier: widget.isStoreOnlineNotifier,
        coffeeMakerStepListWidgets: _coffeeMakerStepListWidgets,
      ),
    );
  }

  void _onCoffeeOrderStatusChange(String coffeeOrderId, [CoffeeMakerStep? newStep]) {
    final currentList = List<CoffeeOrder>.from(_orders.allOrders);
    final updateIndex = currentList.indexWhere((o) => o.id == coffeeOrderId);
    if ([CoffeeMakerStep.addWater, CoffeeMakerStep.ready].contains(newStep)) {
      currentList[updateIndex] = currentList[updateIndex].copyWith(coffeeMakerStep: newStep);
    } else {
      currentList.removeAt(updateIndex);
    }
    return setState(() {
      _orders = GroupedCoffeeOrders.fromCoffeeOrders(currentList);
    });
  }
}
