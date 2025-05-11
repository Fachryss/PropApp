import 'package:flutter/material.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/intro');
    });


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/intro');
    });


    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // Konten tengah
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/dadu.png',
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Text(
                        'PROAPP',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Application for Probability Lesson',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Gambar robot menempel di bawah tanpa jarak putih
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/robot.png',
              width: screenWidth,
              height: screenHeight * 0.20,
              fit: BoxFit.fill, // atau coba BoxFit.cover jika perlu
            ),
          ),
        ],
      ),
    );
  }
}
