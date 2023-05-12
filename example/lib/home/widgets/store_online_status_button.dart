import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/constants/demo_app_constants.dart';

class StoreOnlineStatusButton extends StatelessWidget {
  const StoreOnlineStatusButton({super.key, required this.isStoreOnlineNotifier});

  final ValueNotifier<bool> isStoreOnlineNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isStoreOnlineNotifier,
        builder: (__, isOnline, _) {
          return OutlinedButton(
            child: Row(
              children: [
                SizedBox.square(
                    dimension: 12,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: const CircleBorder(),
                        color: isOnline ? DemoAppColors.green : DemoAppColors.red,
                      ),
                    )),
                SizedBox(width: 8),
                WoltScreenWidthAdaptiveWidget(
                  smallScreenWidthChild: Icon(Icons.store, size: 16, color: Colors.black),
                  largeScreenWidthChild: Text(isOnline ? 'Online' : 'Offline'),
                ),
              ],
            ),
            style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                  side: MaterialStatePropertyAll(BorderSide(width: 2, color: DemoAppColors.gray)),
                ),
            onPressed: () {
              isStoreOnlineNotifier.value = !isStoreOnlineNotifier.value;
            },
          );
        });
  }
}
