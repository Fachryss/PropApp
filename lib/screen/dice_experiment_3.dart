import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:propapp/screen/dice_table_1.dart';
import 'package:propapp/screen/dice_table_3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiceExperimentPage3 extends StatefulWidget {
  const DiceExperimentPage3({super.key});

  @override
  State<DiceExperimentPage3> createState() => _DiceExperimentPageState();
}

class _DiceExperimentPageState extends State<DiceExperimentPage3> {
  String? selectedOption;
  final List<String> options = [
    '30 Kali',
    '100 Kali',
    '200 Kali',
    '500 Kali',
    '1000 Kali'
  ];

  final Random _random = Random();

  Future<Map<String, int>> _rollDice(int numberOfRolls) async {
    final Map<String, int> results = {
      '1': 0,
      '2': 0,
      '3': 0,
      '4': 0,
      '5': 0,
      '6': 0,
      'ganjil': 0,
      'genap': 0,
    };

    for (int i = 0; i < numberOfRolls; i++) {
      int roll = _random.nextInt(6) + 1;
      results[roll.toString()] = (results[roll.toString()] ?? 0) + 1;

      if (roll % 2 == 0){
        results['ganjil'] = (results['ganjil'] ?? 0) + 1;
      } else {
        results['genap'] = (results['genap'] ?? 0) + 1;
      }
    }

    await _saveResultsStorage(numberOfRolls, results);

    return results;
  }

  Future<void> _saveResultsStorage(int totalRools, Map<String, int> result) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('total_rolls_a', totalRools);

    await prefs.setInt('dice_c_1', result['1'] ?? 0);
    await prefs.setInt('dice_c_2', result['2'] ?? 0);
    await prefs.setInt('dice_c_3', result['3'] ?? 0);
    await prefs.setInt('dice_c_4', result['4'] ?? 0);
    await prefs.setInt('dice_c_5', result['5'] ?? 0);
    await prefs.setInt('dice_c_6', result['6'] ?? 0);

    await prefs.setInt('dice_c_ganjil', result['ganjil'] ?? 0);
    await prefs.setInt('dice_c_genap', result['genap'] ?? 0);

    await prefs.setString('dice_result_c', jsonEncode(result));

  }

  

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2939),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Percobaan 3',
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
                      ? () async {
                          final int numberOfRolls =
                              int.parse(selectedOption!.split(' ')[0]);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                          // Mock results for demonstration purposes
                          final Map<String, int> mockResults = await _rollDice(numberOfRolls);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiceResultsTablePage3(
                                totalRolls: numberOfRolls,
                                results: {
                                  '1': mockResults['1'] ?? 0,
                                  '2': mockResults['2'] ?? 0,
                                  '3': mockResults['3'] ?? 0,
                                  '4': mockResults['4'] ?? 0,
                                  '5': mockResults['5'] ?? 0,
                                  '6': mockResults['6'] ?? 0,
                                  'ganjil': mockResults['ganjil'] ?? 0,
                                  'genap': mockResults['genap'] ?? 0,
                                  'total_rolls': numberOfRolls,
                                },
                              ),
                            ),
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
                    selectedOption != null
                        ? 'Roll the dice'
                        : 'Choose how many times',
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
