import 'package:flutter/material.dart';
import 'package:wx_anchor/wx_anchor.dart';
import 'package:wx_text/wx_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      children: <Widget>[
        const SizedBox(height: 40),
        const WxText.displayMedium(
          'WxAnchor',
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          fontWeight: FontWeight.bold,
          letterSpacing: -2,
        ),
        const SizedBox(height: 40),
        Example(
          title: 'Rectangle Shape',
          child: Wrap(
            spacing: 30,
            children: [
              WxAnchor(
                onTap: () {},
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                borderRadius: BorderRadius.circular(5),
                child: const Text('Click Here'),
              ),
              WxAnchor(
                onTap: () {},
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                overlayColor: Colors.amber,
                focusedStyle: const WxAnchorStyle(overlayOpacity: 0.25),
                hoveredStyle: const WxAnchorStyle(overlayOpacity: 0.15),
                pressedStyle: const WxAnchorStyle(
                  overlayOpacity: 0.25,
                  overlayColor: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(5),
                child: const Text('Custom Overlay'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'Circle Shape',
          child: Wrap(
            spacing: 40,
            children: [
              WxAnchor.circle(
                onTap: () {},
                child: const Icon(Icons.chat),
              ),
              WxAnchor.circle(
                onTap: () {},
                radius: 0,
                hoveredStyle: const WxAnchorStyle(radius: 25),
                pressedStyle: const WxAnchorStyle(radius: 20),
                child: const Icon(Icons.power_off),
              ),
              WxAnchor.circle(
                onTap: () {},
                opacity: 1,
                scale: 1,
                overlayDisabled: true,
                hoveredStyle: const WxAnchorStyle(opacity: .7, scale: 1),
                pressedStyle: const WxAnchorStyle(opacity: 1, scale: 1.5),
                child: const Icon(Icons.star),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  const Example({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: WxText.labelLarge(title),
        ),
        Card.outlined(
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: child),
            ),
          ),
        ),
      ],
    );
  }
}
