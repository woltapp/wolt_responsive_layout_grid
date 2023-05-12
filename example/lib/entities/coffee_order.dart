import 'package:equatable/equatable.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';

class CoffeeOrder extends Equatable {
  final String id;
  final CoffeeMakerStep coffeeMakerStep;
  final String orderName;

  const CoffeeOrder({
    required this.id,
    required this.coffeeMakerStep,
    required this.orderName,
  });

  @override
  List<Object?> get props => [id, coffeeMakerStep, orderName];

  CoffeeOrder copyWith({
    String? id,
    CoffeeMakerStep? coffeeMakerStep,
    String? orderName,
  }) {
    return CoffeeOrder(
      id: id ?? this.id,
      coffeeMakerStep: coffeeMakerStep ?? this.coffeeMakerStep,
      orderName: orderName ?? this.orderName,
    );
  }
}
