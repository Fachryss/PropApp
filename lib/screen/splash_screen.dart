import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.casino, size: 24),
                SizedBox(width: 8),
                Text(
                  'PROAPP',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Application for Probability Lesson',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
