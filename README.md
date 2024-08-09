[![Pub Version](https://img.shields.io/pub/v/wx_anchor)](https://pub.dev/packages/wx_anchor) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_wx_anchor) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Clickable zone within a widget that activates an interactive overlay upon touch or hover.

[![Preview](https://github.com/davigmacode/flutter_wx_anchor/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_wx_anchor)

[Demo](https://davigmacode.github.io/flutter_wx_anchor)

## Usage

To read more about classes and other references used by `wx_anchor`, see the [API Reference](https://pub.dev/documentation/wx_anchor/latest/).

### Overlay Effect
`WxAnchor` has a default overlay effect that changes the opacity based on user interactions (`focused`, `hovered`, `pressed`, and `disabled`).
```dart
// Rectangle shape
WxAnchor(
  onTap: () {},
  padding: const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 6,
  ),
  borderRadius: BorderRadius.circular(5),
  child: const Text('Click Here'),
)

// Circle shape
WxAnchor.circle(
  onTap: () {},
  overlayRadius: 20, // overlay radius
  child: const Icon(Icons.chat),
)
```

### Disable Overlay effect
```dart
WxAnchor(
  onTap: () {},
  overlay: false,
  child: const Text('Click Here'),
)
```

### Customize Overlay Effect
```dart
// Changes overlay opacity based on user interaction
WxAnchor(
  onTap: () {},
  overlayColor: Colors.amber,
  focusedStyle: const WxAnchorStyle(overlayOpacity: 0.25),
  hoveredStyle: const WxAnchorStyle(overlayOpacity: 0.15),
  pressedStyle: const WxAnchorStyle(
    overlayOpacity: 0.25,
    overlayColor: Colors.red,
  ),
  borderRadius: BorderRadius.circular(15),
  child: const Icon(Icons.power_off),
)

// Changes overlay radius based on user interaction
WxAnchor.circle(
  onTap: () {},
  overlayRadius: 0,
  hoveredStyle: const WxAnchorStyle.circle(overlayRadius: 25),
  pressedStyle: const WxAnchorStyle.circle(overlayRadius: 20),
  child: const Icon(Icons.power_off),
)
```

### Child Opacity & Scale
```dart
WxAnchor.circle(
  onTap: () {},
  opacity: 1,
  scale: 1,
  overlay: false,
  hoveredStyle: const WxAnchorStyle(opacity: .7, scale: 1.1),
  pressedStyle: const WxAnchorStyle(opacity: 1, scale: 1),
  child: const Icon(Icons.chat),
)
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.