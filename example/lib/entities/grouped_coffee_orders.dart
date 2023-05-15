import 'package:equatable/equatable.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_order.dart';

class GroupedCoffeeOrders extends Equatable {
  final List<CoffeeOrder> grindStateOrders;
  final List<CoffeeOrder> addWaterStateOrders;
  final List<CoffeeOrder> readyStateOrders;

  const GroupedCoffeeOrders({
    required this.grindStateOrders,
    required this.addWaterStateOrders,
    required this.readyStateOrders,
  });

  factory GroupedCoffeeOrders.fromCoffeeOrders(List<CoffeeOrder> coffeeOrders) {
    final grindStateOrders =
        coffeeOrders.where((o) => o.coffeeMakerStep == CoffeeMakerStep.grind).toList();
    final addWaterStateOrders =
        coffeeOrders.where((o) => o.coffeeMakerStep == CoffeeMakerStep.addWater).toList();
    final readyStateOrders =
        coffeeOrders.where((o) => o.coffeeMakerStep == CoffeeMakerStep.ready).toList();
    return GroupedCoffeeOrders(
      grindStateOrders: grindStateOrders,
      addWaterStateOrders: addWaterStateOrders,
      readyStateOrders: readyStateOrders,
    );
  }

  List<CoffeeOrder> get allOrders => [
        ...grindStateOrders,
        ...addWaterStateOrders,
        ...readyStateOrders,
      ];

  @override
  List<Object?> get props => [grindStateOrders, addWaterStateOrders, readyStateOrders];

  int countForStep(CoffeeMakerStep step) {
    switch (step) {
      case CoffeeMakerStep.grind:
        return grindStateOrders.length;
      case CoffeeMakerStep.addWater:
        return addWaterStateOrders.length;
      case CoffeeMakerStep.ready:
        return readyStateOrders.length;
    }
  }
}
