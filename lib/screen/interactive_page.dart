import 'package:flutter/material.dart';

class ProbabilitySelectionPage extends StatefulWidget {
  const ProbabilitySelectionPage({super.key});

  @override
  State<ProbabilitySelectionPage> createState() =>
      _ProbabilitySelectionPageState();
}

class _ProbabilitySelectionPageState extends State<ProbabilitySelectionPage> {
  String? selectedOption;

  bool get hasSelection => selectedOption != null;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 51),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.001),
              Text(
                'Media mana yang kamu pilih\nuntuk belajar peluang: dadu\natau koin?',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Text(
                'Mana yang kamu pilih?',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Coin option (gambar koin)
              _buildSelectionItem(
                'coin',
                'Koin',
                Image.asset(
                  'assets/images/dadu2.png', // sesuai kode awal kamu
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: screenHeight * 0.035),

              // Dice option (gambar dadu)
              _buildSelectionItem(
                'dice',
                'Dadu',
                Image.asset(
                  'assets/images/Koin.png', // sesuai kode awal kamu
                  color: Colors.white,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Tombol Next
              AnimatedOpacity(
                opacity: hasSelection ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: hasSelection ? 56 : 0,
                  width: double.infinity,
                  child: hasSelection
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/dice');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D2939),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionItem(String value, String label, Widget image) {
    final isSelected = selectedOption == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = isSelected ? null : value;
        });
      },
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: image,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
