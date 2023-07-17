[![pub package](https://img.shields.io/pub/v/wolt_responsive_layout_grid.svg)](https://pub.dev/packages/wolt_responsive_layout_grid)
[![package publisher](https://img.shields.io/pub/publisher/wolt_responsive_layout_grid.svg)](https://pub.dev/packages/wolt_responsive_layout_grid/publisher)

# WoltResponsiveLayoutGrid

Creating responsive grid layouts in Flutter applications can be a challenging task. Developers often struggle with achieving consistent and adaptive designs across various screen sizes and orientations. With the Wolt Responsive Layout Grid library, building responsive grid layouts becomes much simpler.

Wolt Responsive Layout Grid library introduces the Flutter implementation of [Material Design's responsive layout grid](https://m2.material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins). It provides a unified, multi-platform grid system that ensures consistency and visual integrity regardless of the device or operating system being used.

  <img src="https://raw.githubusercontent.com/woltapp/wolt-responsive-layout-grid/main/doc/sample.gif?raw=true"
    alt="An animated image of the sample app" height="400"/>

## Features

The Wolt Responsive Layout Grid library offers the following key features:

__Responsive Grid Layout__: The WoltResponsiveLayoutGrid widget enables the creation of responsive grid layouts that adapt to different screen sizes and orientations.

__Material Design Adaptation__: The library implements Material Design's responsive layout grid, guaranteeing consistency and adhering to established design principles. 

__Customizable Spacing__: By adjusting the gutter and margin properties of the WoltResponsiveLayoutGrid widget, developers have full control over the spacing, allowing developers to create layouts that match the design requirements.

__Screen Width Adaptation__: The WoltScreenWidthAdaptiveWidget allows developers to adapt the child widget based on the screen width, dynamically adjusting the layout and content presentation. By providing different child widgets for small and large screens, the WoltScreenWidthAdaptiveWidget automatically switches between them based on the screen width, ensuring a seamless user experience across various devices.

__Overlay for Visual Debugging__: During development, it's often helpful to have a visual representation of the grid layout to fine-tune and verify its structure. The Wolt Responsive Layout Grid library includes an overlay feature that enables you to visualize the grid layout. This overlay renders colored boxes for each column and gutter, making it easier to debug and ensure proper alignment. The overlay can be enabled or disabled based on debugging needs.
## Getting started
To use this plugin, add `wolt_responsive_layout_grid` as a dependency in your pubspec.yaml file.

## Usage
### WoltResponsiveLayoutGrid

The `WoltResponsiveLayoutGrid` widget is the centerpiece of the library. By utilizing a list of `WoltColumnSpanCell` objects, you can define the content and column spans for each cell. This allows for the grouping of one or more columns to create sections or content within the available space.

```dart
WoltResponsiveLayoutGrid(
  isOverlayVisible: true,
  gutter: 16,
  margin: 32,
  columnSpanCells: [
    WoltColumnSpanCell(
      columnCellWidget: Placeholder(color: Colors.blue, strokeWidth: 4),
      columnSpan: 4,
    ),
    WoltColumnSpanCell(
      columnCellWidget: Placeholder(color: Colors.red, strokeWidth: 4),
      columnSpan: 6,
    ),
    WoltColumnSpanCell(
      columnCellWidget: Placeholder(color: Colors.green, strokeWidth: 4),
      columnSpan: 2,
    ),
  ],
)
```

<img src="https://raw.githubusercontent.com/woltapp/wolt-responsive-layout-grid/main/doc/example_app_2.png" height="400"/>\
  
__Centered Constructor__

`WoltResponsiveLayoutGrid` widget provides a factory constructor `centered` that simplifies the creation of centered layouts with a child widget and specified column counts. This constructor takes the following parameters: 

`child`: The child widget to be centered within the grid layout.

`centerWidgetColumnCount`: The number of columns that the child widget should occupy.

`paddedColumnCountPerSide`: The number of padded columns to be added on each side of the child widget. These padded columns create empty spaces around the centered widget, resulting in a visually balanced and appealing layout.


```dart
WoltResponsiveLayoutGrid.centered(
  centerWidgetColumnCount: 3,
  paddedColumnCountPerSide: 2,
  margin: 32,
  gutter: 16,
  isOverlayVisible: true,
  child: DecoratedBox(
    decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
    child: Text(
      'Center Widget',
      style: Theme.of(context).textTheme.displayLarge,
      textAlign: TextAlign.center,
    ),
  ),
),
```

| Tablet - Portrait                                                                                                        | Tablet - Landscape                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| <img width=300 src=https://raw.githubusercontent.com/woltapp/wolt-responsive-layout-grid/main/doc/centered_vertical.png> | <img width=300 src=https://raw.githubusercontent.com/woltapp/wolt-responsive-layout-grid/main/doc/centered_horizontal.png> |


### WoltScreenWidthAdaptiveWidget
The `WoltScreenWidthAdaptiveWidget` is designed to provide adaptive rendering based on the screen width. It allows developers to define two child widgets: one for small screens and another for large screens. The widget automatically switches between the child widgets based on the screen width, ensuring that the interface adapts seamlessly to different device sizes. 

```dart

WoltScreenWidthAdaptiveWidget(
  smallScreenWidthChild: Icon(Icons.store, size: 16, color: Colors.black),
  largeScreenWidthChild: Text(isOnline ? 'Online' : 'Offline'),
),
```
<img src="https://raw.githubusercontent.com/woltapp/wolt-responsive-layout-grid/main/doc/screen_width_adaptive_widget.gif?raw=true">

## Additional information
To learn more, you can check the following blog posts:
- [Technical implementation details of the package](https://careers.wolt.com/en/blog/tech/wolt-responsive-layout-grid-a-solution-for-adaptive-and-consistent-multi)
- [CoffeeMaker demo app with the package](https://careers.wolt.com/en/blog/tech/creating-responsive-layouts-with-woltresponsivelayoutgrid-a-coffeemaker-demo)
