import 'package:flutter/material.dart';

class MultipleChoicePage extends StatelessWidget {
  const MultipleChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiple Choice')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/closing'),
          child: const Text('Next'),
        ),
      ),
    );
  }
}