import 'package:flutter/material.dart';
import 'package:wolt_responsive_layout_grid/wolt_responsive_layout_grid.dart';
import 'package:wolt_responsive_layout_grid_example/constants/demo_app_constants.dart';
import 'package:wolt_responsive_layout_grid_example/home/widgets/top_bar.dart';

/// The content displayed when the store is in the offline state.
class StoreOfflineContent extends StatefulWidget {
  /// Creates a new instance of [StoreOfflineContent] widget.
  ///
  /// The [isStoreOnlineNotifier] is a [ValueNotifier] that tracks the online state of the store.
  const StoreOfflineContent({
    required ValueNotifier<bool> isStoreOnlineNotifier,
    Key? key,
  })  : _isStoreOnlineNotifier = isStoreOnlineNotifier,
        super(key: key);

  final ValueNotifier<bool> _isStoreOnlineNotifier;

  @override
  State<StoreOfflineContent> createState() => _StoreOfflineContentState();
}

class _StoreOfflineContentState extends State<StoreOfflineContent> {
  late bool _isOverlayVisible;

  @override
  void initState() {
    super.initState();
    _isOverlayVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final content = _OfflineContent(isStoreOnlineNotifier: widget._isStoreOnlineNotifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => setState(() => _isOverlayVisible = !_isOverlayVisible),
              child: TopBar(
                isStoreOnlineNotifier: widget._isStoreOnlineNotifier,
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: DemoAppColors.red,
                child: WoltScreenWidthAdaptiveWidget(
                  smallScreenWidthChild: SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: content,
                    ),
                  ),
                  largeScreenWidthChild: WoltResponsiveLayoutGrid.centered(
                    child: content,
                    centerWidgetColumnCount: 2,
                    paddedColumnCountPerSide: 1,
                    isOverlayVisible: _isOverlayVisible,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineContent extends StatelessWidget {
  const _OfflineContent({
    required ValueNotifier<bool> isStoreOnlineNotifier,
  }) : _isStoreOnlineNotifier = isStoreOnlineNotifier;

  final ValueNotifier<bool> _isStoreOnlineNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You are offline',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.bold, color: DemoAppColors.white),
        ),
        const SizedBox(height: 12),
        Text(
          'Go online to receive new orders.',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: DemoAppColors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 56,
          child: OutlinedButton(
            onPressed: () => _isStoreOnlineNotifier.value = true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
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
