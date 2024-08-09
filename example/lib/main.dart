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
            crossAxisAlignment: WrapCrossAlignment.center,
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
                overlayExtent: Size.zero,
                overlayColor: Colors.amber,
                focusedStyle: const WxAnchorStyle(
                  overlayOpacity: 0.25,
                  overlayExtent: Size(130, 40),
                ),
                hoveredStyle: const WxAnchorStyle(
                  overlayOpacity: 0.15,
                  overlayExtent: Size(130, 40),
                ),
                pressedStyle: WxAnchorStyle.rectangle(
                  overlayOpacity: 0.25,
                  overlayColor: Colors.blue,
                  overlayExtent: const Size(120, 30),
                  borderRadius: BorderRadius.circular(5),
                ),
                borderRadius: BorderRadius.circular(15),
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
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              WxAnchor.circle(
                onTap: () {},
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.chat),
              ),
              WxAnchor.circle(
                onTap: () {},
                overlayRadius: 0,
                hoveredStyle: WxAnchorStyle.circle(overlayRadius: 25),
                pressedStyle: WxAnchorStyle.circle(overlayRadius: 20),
                focusedStyle: WxAnchorStyle.circle(overlayRadius: 20),
                child: const Icon(Icons.power_off),
              ),
              WxAnchor.circle(
                onTap: () {},
                opacity: 1,
                scale: 1,
                overlay: false,
                hoveredStyle: const WxAnchorStyle(opacity: .7, scale: 1),
                pressedStyle: const WxAnchorStyle(opacity: 1, scale: 1.5),
                focusedStyle: const WxAnchorStyle(opacity: 1, scale: 1.5),
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
