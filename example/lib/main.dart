import 'package:flutter/material.dart';
import 'package:wx_anchor/wx_anchor.dart';

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
            Anchor(
              onTap: () {},
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              borderRadius: BorderRadius.circular(5),
              child: const Text('Click Here'),
            ),
            const SizedBox(height: 20),
            Anchor.circle(
              onTap: () {},
              radius: 20,
              child: const Icon(Icons.chat),
            ),
          ],
        ),
      ),
    );
  }
}
