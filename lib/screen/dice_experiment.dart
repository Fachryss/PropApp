import 'package:flutter/material.dart';

class DiceExperimentPage extends StatefulWidget {
  const DiceExperimentPage({super.key});

  @override
  State<DiceExperimentPage> createState() => _DiceExperimentPageState();
}

class _DiceExperimentPageState extends State<DiceExperimentPage> {
  String? selectedOption;
  final List<String> options = ['30 Kali', '100 Kali', '200 Kali', '500 Kali', '1000 Kali'];

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
              // Header section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2939),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Percobaan 1',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Instruction text
              const Text(
                'Anda bisa memilih beberapa kali percobaan yang ingin anda lakukan.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // color: Colors.black54,
                ),
              ),
              
              const SizedBox(height: 36),
              
              // Option buttons
              ...options.map((option) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildOptionButton(option),
              )),
              
              const Spacer(),
              
              // Bottom button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedOption != null 
                    ? () {
                        // Navigate to dice rolling animation or results
                        Navigator.pushNamed(
                          context, 
                          '/dice_rolling', 
                          arguments: int.parse(selectedOption!.split(' ')[0])
                        );
                      }
                    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOption != null 
                      ? const Color(0xFF1D2939) 
                      : Colors.grey.shade200,
                    foregroundColor: selectedOption != null 
                      ? Colors.white 
                      : Colors.grey.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    selectedOption != null ? 'Roll the dice' : 'Choose how many times',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: selectedOption != null 
                        ? Colors.white 
                        : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    final isSelected = selectedOption == option;
    
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D2939) : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          option,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}