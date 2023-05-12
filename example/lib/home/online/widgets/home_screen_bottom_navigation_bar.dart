import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid_example/constants/demo_app_constants.dart';
import 'package:wolt_responsive_layout_grid_example/entities/coffee_maker_step.dart';
import 'package:wolt_responsive_layout_grid_example/home/widgets/wolt_custom_divider.dart';

typedef OnCoffeeMakerStepSelected = void Function(CoffeeMakerStep selectedStep);

class HomeScreenBottomNavigationBar extends StatelessWidget {
  const HomeScreenBottomNavigationBar({
    required this.selectedStep,
    required this.onSelected,
    super.key,
  });

  final CoffeeMakerStep selectedStep;
  final OnCoffeeMakerStepSelected onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WoltCustomDivider(),
        NavigationBar(
          destinations: [
            for (CoffeeMakerStep step in CoffeeMakerStep.values)
              step._navigationDestination(isSelected: step == selectedStep),
          ],
          selectedIndex: selectedStep.index,
          onDestinationSelected: (i) {
            onSelected(CoffeeMakerStep.values.firstWhere((e) => e.stepNumber == i));
          },
        ),
      ],
    );
  }
}

class NavigationDestinationData {
  final Widget icon;
  final Widget selectedIcon;
  final String label;

  const NavigationDestinationData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

extension CoffeeMakerStepExtension on CoffeeMakerStep {
  NavigationDestination _navigationDestination({required bool isSelected}) {
    switch (this) {
      case CoffeeMakerStep.grind:
        return NavigationDestination(
          icon: _DestinationIcon(Icons.add_circle_outline_outlined, isSelected: isSelected),
          selectedIcon: _DestinationIcon(Icons.add_circle_rounded, isSelected: isSelected),
          label: stepName,
        );
      case CoffeeMakerStep.addWater:
        return NavigationDestination(
          icon: _DestinationIcon(Icons.water_drop_outlined, isSelected: isSelected),
          selectedIcon: _DestinationIcon(Icons.water_drop_rounded, isSelected: isSelected),
          label: stepName,
        );
      case CoffeeMakerStep.ready:
        return NavigationDestination(
          icon: _DestinationIcon(Icons.coffee, isSelected: isSelected),
          selectedIcon: _DestinationIcon(Icons.coffee_rounded, isSelected: isSelected),
          label: stepName,
        );
    }
  }
}

class _DestinationIcon extends StatelessWidget {
  const _DestinationIcon(
    this.iconData, {
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Icon(iconData, color: isSelected ? DemoAppColors.blue : DemoAppColors.black64);
  }
}
