import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid_example/entities/grouped_coffee_orders.dart';
import 'package:wolt_responsive_layout_grid_example/home/offline/store_offline_content.dart';
import 'package:wolt_responsive_layout_grid_example/home/online/store_online_content.dart';

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

  @override
  void initState() {
    super.initState();
    _isStoreOnlineNotifier = ValueNotifier(widget.isStoreOnline);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isStoreOnlineNotifier,
      builder: (_, bool isStoreOnline, __) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isStoreOnline
              ? StoreOnlineContent(
                  groupedCoffeeOrders: widget.groupedCoffeeOrders,
                  isStoreOnlineNotifier: _isStoreOnlineNotifier,
                )
              : StoreOfflineContent(isStoreOnlineNotifier: _isStoreOnlineNotifier),
        );
      },
    );
  }
}
