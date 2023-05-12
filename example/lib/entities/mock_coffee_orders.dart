import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_order.dart';

const List<CoffeeOrder> mockCoffeeOrders = <CoffeeOrder>[
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.grind, orderName: 'Cagatay U.', id: '#001'),
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.grind, orderName: 'Ege A.', id: '#002'),
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.grind, orderName: 'Yunus B.', id: '#003'),
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.grind, orderName: 'Murat T.', id: '#004'),
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.grind, orderName: 'Ali R.', id: '#005'),
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.grind, orderName: 'Antti R.', id: '#006'),
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.addWater, orderName: 'Otto O.', id: '#007'),
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.addWater, orderName: 'Gizem K.', id: '#008'),
  CoffeeOrder(coffeeMakerStep: CoffeeMakerStep.ready, orderName: 'Raza P.', id: '#009'),
];
