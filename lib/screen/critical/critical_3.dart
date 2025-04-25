import 'package:flutter/material.dart';

class Critical3Page extends StatelessWidget {
  const Critical3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Critical Thinking 3')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/checkbox'),
          child: const Text('Next'),
        ),
      ),
    );
  }
}