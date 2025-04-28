import 'package:flutter/material.dart';

class ProbabilitySelectionPage extends StatefulWidget {
  const ProbabilitySelectionPage({super.key});

  @override
  State<ProbabilitySelectionPage> createState() => _ProbabilitySelectionPageState();
}

class _ProbabilitySelectionPageState extends State<ProbabilitySelectionPage> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Media mana yang kamu pilih\nuntuk belajar peluang: dadu\natau koin?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Mana yang kamu pilih?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40),
              
              // Coin option
              _buildSelectionItem(
                'coin',
                'Koin',
                Image.asset(
                  'assets/image/dadu.png',
                  // width: 100,
                  // height: 100,
                  fit: BoxFit.fitWidth,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Dice option
              _buildSelectionItem(
                'dice',
                'Dadu',
                Image.network(
                  'https://placeholder',
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D2939),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.circle,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
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
                              Navigator.pushNamed(context, '/dice_probability');
                            } else {
                              Navigator.pushNamed(context, '/coin_probability');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D2939),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            'Lanjutkan',
                            style: TextStyle(
                              fontSize: 16,
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
          selectedOption = value;
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          color: const Color.fromARGB(255, 31, 41, 55)
        ),
        // padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              // height: 200,
              child: Center(child: image),
            ),
            // const SizedBox(height: 16),
            // Text(
            //   label,
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     color: isSelected ? Colors.blue : Colors.black87,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}