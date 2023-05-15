import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/home/widgets/store_online_status_button.dart';
import 'package:wolt_responsive_layout_grid_example/home/widgets/wolt_custom_divider.dart';

class WoltTopBar extends StatelessWidget {
  const WoltTopBar({
    required this.isStoreOnlineNotifier,
    this.selectedStepForBottomNavigationBar,
    super.key,
  });

  final CoffeeMakerStep? selectedStepForBottomNavigationBar;
  final ValueNotifier<bool> isStoreOnlineNotifier;

  @override
  Widget build(BuildContext context) {
    late String title;
    final store = 'Coffee Maker';
    final selectedStep = selectedStepForBottomNavigationBar;
    switch (context.screenSize) {
      case WoltScreenSize.small:
        title = isStoreOnlineNotifier.value && selectedStep != null ? selectedStep.stepName : store;
        break;
      case WoltScreenSize.large:
        title = store;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16) - const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 16),
              StoreOnlineStatusButton(isStoreOnlineNotifier: isStoreOnlineNotifier),
            ],
          ),
        ),
        WoltCustomDivider(),
      ],
    );
  }
}
