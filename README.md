[![Pub Version](https://img.shields.io/pub/v/wx_anchor)](https://pub.dev/packages/wx_anchor) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_wx_anchor) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Clickable zone within a widget that activates an interactive overlay upon touch or hover.

[![Preview](https://github.com/davigmacode/flutter_wx_anchor/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_wx_anchor)

[Demo](https://davigmacode.github.io/flutter_wx_anchor)

## Usage

To read more about classes and other references used by `wx_anchor`, see the [API Reference](https://pub.dev/documentation/wx_anchor/latest/).

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
  radius: 20,
  child: const Icon(Icons.chat),
)

// Circle shape with complex interaction
WxAnchor(
  onTap: () {},
  style: const WxDrivenAnchorStyle.circle(
    radius: 0,
    hoveredStyle: WxAnchorStyle(radius: 25),
    pressedStyle: WxAnchorStyle(radius: 20),
  ),
  child: const Icon(Icons.power_off),
)
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.