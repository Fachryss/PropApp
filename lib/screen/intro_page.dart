import 'package:flutter/material.dart';
import '../widget/primary_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrimaryButton(
          text: 'Start',
          onPressed: () {
            Navigator.pushNamed(context, '/critical1');
          },
        ),
      ),
    );
  }
}