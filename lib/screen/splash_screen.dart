import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/intro');
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Menambah jarak vertikal di atas teks PROAPP
                  const SizedBox(height: 80), // Menambahkan jarak ke atas

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/dadu.png',
                        width: 75,
                        height: 75,
                      ),
                      const SizedBox(),
                      const Text(
                        'PROAPP',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(), // Menambah jarak antara "PROAPP" dan deskripsi
                  const Text(
                    'Application for Probability Lesson',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/robot.png',
              fit: BoxFit.cover, // Ganti dengan gambar bawah kamu
            ),
          ),
        ],
      ),
    );
  }
}
