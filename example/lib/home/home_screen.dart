import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/entities/grouped_coffee_orders.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/widgets/home_screen_bottom_navigation_bar.dart';
import 'package:wolt_responsive_layout_grid_example/home/offline/store_offline_content.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/store_online_content.dart';
import 'package:wolt_responsive_layout_grid_example/home/widgets/wolt_top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.groupedCoffeeOrders,
    required this.isStoreOnline,
    super.key,
  });

  final GroupedCoffeeOrders groupedCoffeeOrders;
  final bool isStoreOnline;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ValueNotifier<bool> _isStoreOnlineNotifier;
  late CoffeeMakerStep _selectedStepForBottomNavigationBar;
  late bool _isOverlayVisible;

  Widget? get _bottomNavigationBar {
    switch (context.screenSize) {
      case WoltScreenSize.small:
        return HomeScreenBottomNavigationBar(
          selectedStep: _selectedStepForBottomNavigationBar,
          onSelected: (selectedStep) {
            setState(() {
              _selectedStepForBottomNavigationBar = selectedStep;
            });
          },
        );
      case WoltScreenSize.large:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _isOverlayVisible = false;
    _isStoreOnlineNotifier = ValueNotifier(widget.isStoreOnline);
    _selectedStepForBottomNavigationBar = CoffeeMakerStep.grind;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() => _isOverlayVisible = !_isOverlayVisible);
              },
              child: WoltTopBar(
                selectedStepForBottomNavigationBar: _selectedStepForBottomNavigationBar,
                isStoreOnlineNotifier: _isStoreOnlineNotifier,
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _isStoreOnlineNotifier,
                builder: (_, bool isStoreOnline, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isStoreOnline
                        ? StoreOnlineContent(
                            groupedCoffeeOrders: widget.groupedCoffeeOrders,
                            selectedStepForBottomNavigationBar: _selectedStepForBottomNavigationBar,
                            isOverlayVisible: _isOverlayVisible,
                          )
                        : StoreOfflineContent(isStoreOnlineNotifier: _isStoreOnlineNotifier),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar,
    );
  }
}
