import 'package:flutter/material.dart';

class QuestionCheckboxPage extends StatelessWidget {
  const QuestionCheckboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question - Checkbox')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/interactive'),
          child: const Text('Next'),
        ),
      ),
    );
  }
}