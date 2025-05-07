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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 51),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Media mana yang kamu pilih\nuntuk belajar peluang: dadu\natau koin?',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 13),
              const Text(
                'Mana yang kamu pilih?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              const Spacer(),

              // Coin option
              _buildSelectionItem(
                'coin',
                'Koin',
                Image.asset(
                  'assets/images/dadu2.png',
                  width: double.infinity,
                  height: 220,
                ),
              ),

              const SizedBox(height: 27),

              // Dice option
              _buildSelectionItem(
                'dice',
                'Dadu',
                Image.asset(
                  'assets/images/Koin.png',
                  color: Colors.white,
                  width: double.infinity,
                  height: 220,
                ),
              ),

              const Spacer(),

              // Next button that appears only when an option is selected
              AnimatedOpacity(
                opacity: selectedOption != null ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: selectedOption != null ? 56 : 0,
                  width: double.infinity,
                  child: selectedOption != null
                      ? ElevatedButton(
                          onPressed: () {
                            // Navigate to the appropriate page based on selection
                            if (selectedOption == 'dice') {
                              Navigator.pushNamed(context, '/dice');
                            } else {
                              Navigator.pushNamed(context, '/dice');
                            }
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
        scale: isSelected ? 1.050 : 1.0, // Perbesar sedikit jika dipilih
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
              borderRadius: BorderRadius.circular(14), // 12 - 2 (margin)
            ),
            child: Column(
              children: [
                SizedBox(
                  child: Center(child: image),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
