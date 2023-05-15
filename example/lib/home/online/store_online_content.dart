import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/constants/demo_app_constants.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_order.dart';
import 'package:wolt_responsive_layout_grid_example/entities/grouped_coffee_orders.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/coffee_order_list_widget.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/large_screen_coffee_order_list_section.dart';

typedef OnCoffeeOrderStatusChange = Function(String coffeeOrderId, [CoffeeMakerStep? newStep]);

class StoreOnlineContent extends StatefulWidget {
  const StoreOnlineContent({
    required this.selectedStepForBottomNavigationBar,
    required this.groupedCoffeeOrders,
    required this.isOverlayVisible,
    super.key,
  });

  final CoffeeMakerStep selectedStepForBottomNavigationBar;
  final GroupedCoffeeOrders groupedCoffeeOrders;
  final bool isOverlayVisible;

  @override
  State<StoreOnlineContent> createState() => _StoreOnlineContentState();
}

class _StoreOnlineContentState extends State<StoreOnlineContent> {
  late GroupedCoffeeOrders _orders;

  initState() {
    super.initState();
    _orders = widget.groupedCoffeeOrders;
  }

  Widget get _selectedCoffeeMakerStepListWidgetForSmallScreen =>
      _coffeeMakerStepListWidgets[widget.selectedStepForBottomNavigationBar]!;

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
      smallScreenWidthChild: _SmallScreenOnlineContent(
        child: _selectedCoffeeMakerStepListWidgetForSmallScreen,
      ),
      largeScreenWidthChild: _LargeScreenOnlineContent(
        coffeeMakerStepListWidgets: _coffeeMakerStepListWidgets,
        isOverlayVisible: widget.isOverlayVisible,
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

class _SmallScreenOnlineContent extends StatelessWidget {
  const _SmallScreenOnlineContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: DemoAppColors.black4,
      child: child,
    );
  }
}

class _LargeScreenOnlineContent extends StatelessWidget {
  const _LargeScreenOnlineContent({
    required this.coffeeMakerStepListWidgets,
    required this.isOverlayVisible,
  });

  final Map<CoffeeMakerStep, CoffeeOrderListWidget> coffeeMakerStepListWidgets;
  final bool isOverlayVisible;

  @override
  Widget build(BuildContext context) {
    return WoltResponsiveLayoutGrid(
      margin: 8,
      gutter: 8,
      isOverlayVisible: isOverlayVisible,
      gridContentList: [
        WoltResponsiveLayoutGridContent(
          columnCount: 3,
          content: LargeScreenCoffeeOrderListSection(
            coffeeMakerStep: CoffeeMakerStep.grind,
            coffeeOrderListWidget: coffeeMakerStepListWidgets[CoffeeMakerStep.grind]!,
          ),
        ),
        WoltResponsiveLayoutGridContent(
          columnCount: 3,
          content: LargeScreenCoffeeOrderListSection(
            coffeeMakerStep: CoffeeMakerStep.addWater,
            coffeeOrderListWidget: coffeeMakerStepListWidgets[CoffeeMakerStep.addWater]!,
          ),
        ),
        WoltResponsiveLayoutGridContent(
          columnCount: 2,
          content: LargeScreenCoffeeOrderListSection(
            coffeeMakerStep: CoffeeMakerStep.ready,
            coffeeOrderListWidget: coffeeMakerStepListWidgets[CoffeeMakerStep.ready]!,
          ),
        ),
      ],
    );
  }
}
