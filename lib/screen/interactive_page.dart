import 'package:flutter/material.dart';

class InteractivePage extends StatelessWidget {
  const InteractivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/multiple'),
          child: const Text('Next'),
        ),
      ),
    );
  }
}