import 'package:flutter/material.dart';

class Critical1Page extends StatelessWidget {
  const Critical1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Critical Thinking 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/critical2'),
          child: const Text('Next'),
        ),
      ),
    );
  }
}