import 'package:flutter/material.dart';

class Critical2Page extends StatelessWidget {
  const Critical2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Critical Thinking 2')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/critical3'),
          child: const Text('Next'),
        ),
      ),
    );
  }
}