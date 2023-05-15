import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid_example/constants/demo_app_constants.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/entities/grouped_coffee_orders.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/coffee_order_list_widget.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/small_screen/home_screen_bottom_navigation_bar.dart';
import 'package:wolt_responsive_layout_grid_example/home/widgets/wolt_top_bar.dart';

class SmallScreenOnlineContent extends StatefulWidget {
  const SmallScreenOnlineContent({
    required this.coffeeMakerStepListWidgets,
    required this.isStoreOnlineNotifier,
    required this.groupedCoffeeOrders,
    super.key,
  });

  final ValueNotifier<bool> isStoreOnlineNotifier;
  final Map<CoffeeMakerStep, CoffeeOrderListWidget> coffeeMakerStepListWidgets;
  final GroupedCoffeeOrders groupedCoffeeOrders;

  @override
  State<SmallScreenOnlineContent> createState() => _SmallScreenOnlineContentState();
}

class _SmallScreenOnlineContentState extends State<SmallScreenOnlineContent> {
  late CoffeeMakerStep _selectedStepForBottomNavigationBar;

  initState() {
    super.initState();
    _selectedStepForBottomNavigationBar = CoffeeMakerStep.grind;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            WoltTopBar(
              selectedStepForBottomNavigationBar: _selectedStepForBottomNavigationBar,
              isStoreOnlineNotifier: widget.isStoreOnlineNotifier,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: DemoAppColors.black4,
                child: widget.coffeeMakerStepListWidgets[_selectedStepForBottomNavigationBar]!,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeScreenBottomNavigationBar(
        groupedCoffeeOrders: widget.groupedCoffeeOrders,
        selectedStep: _selectedStepForBottomNavigationBar,
        onSelected: (selectedStep) {
          setState(() {
            _selectedStepForBottomNavigationBar = selectedStep;
          });
        },
      ),
    );
  }
}
