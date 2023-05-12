import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/constants/demo_app_constants.dart';

class StoreOfflineContent extends StatelessWidget {
  const StoreOfflineContent({required this.isStoreOnlineNotifier, super.key});

  final ValueNotifier<bool> isStoreOnlineNotifier;

  @override
  Widget build(BuildContext context) {
    final storeOfflineContent = _StoreOfflineContent(isStoreOnlineNotifier: isStoreOnlineNotifier);
    return ColoredBox(
      color: DemoAppColors.red,
      child: WoltScreenWidthAdaptiveWidget(
        smallScreenWidthChild: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: storeOfflineContent,
          ),
        ),
        largeScreenWidthChild: WoltResponsiveLayoutGrid.centered(
          child: storeOfflineContent,
          centerWidgetColumnCount: 1,
          horizontalPaddedColumnCount: 2,
        ),
      ),
    );
  }
}

class _StoreOfflineContent extends StatelessWidget {
  const _StoreOfflineContent({required this.isStoreOnlineNotifier});

  final ValueNotifier<bool> isStoreOnlineNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You are offline',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.bold, color: DemoAppColors.white),
        ),
        const SizedBox(height: 12),
        Text(
          'Go online to receive new orders.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: DemoAppColors.white),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 56,
          child: OutlinedButton(
            onPressed: () => isStoreOnlineNotifier.value = true,
            child: Center(
              child: const Text(
                'Go online',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
