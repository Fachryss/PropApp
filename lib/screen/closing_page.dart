import 'package:flutter/material.dart';

class ClosingPage extends StatelessWidget {
  const ClosingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 350, 25, 51),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Terima Kasih",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D2939),
                      ),
                    ),
                    SizedBox(height: 10), // Add spacing between the texts
                    Text(
                      "Sudah menggunakan aplikasi ini untuk belajar peluang dalam matematika.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  // Image.asset(
                  //   "assets/images/LogoMokletDev.jpg",
                  //   width: 50,
                  //   height: 50,
                  // ),
                  const SizedBox(height: 10),
                  const Text(
                    "Tim MokletDev",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
