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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            const WxText.displayMedium('WxAnchor'),
            const SizedBox(height: 40),
            Wrapper(
              title: 'Rectangle Shape',
              child: WxAnchor(
                onTap: () {},
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                borderRadius: BorderRadius.circular(5),
                child: const Text('Click Here'),
              ),
            ),
            const SizedBox(height: 20),
            Wrapper(
              title: 'Circle Shape',
              child: Wrap(
                spacing: 20,
                children: [
                  WxAnchor.circle(
                    onTap: () {},
                    radius: 20,
                    child: const Icon(Icons.chat),
                  ),
                  WxAnchor(
                    onTap: () {},
                    style: const WxDrivenAnchorStyle.circle(
                      radius: 0,
                      hoveredStyle: WxAnchorStyle(radius: 25),
                      pressedStyle: WxAnchorStyle(radius: 20),
                    ),
                    child: const Icon(Icons.power_off),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
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
            width: 250,
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
