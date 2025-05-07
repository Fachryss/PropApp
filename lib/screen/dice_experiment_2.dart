import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:propapp/screen/dice_table_1.dart';
import 'package:propapp/screen/dice_table_2dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiceExperimentPage2 extends StatefulWidget {
  const DiceExperimentPage2({super.key});

  @override
  State<DiceExperimentPage2> createState() => _DiceExperimentPageState();
}

class _DiceExperimentPageState extends State<DiceExperimentPage2> {
  String? selectedOption;

  bool get hasSelection => selectedOption != null;

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

      if (roll % 2 == 0) {
        results['ganjil'] = (results['ganjil'] ?? 0) + 1;
      } else {
        results['genap'] = (results['genap'] ?? 0) + 1;
      }
    }

    await _saveResultsStorage(numberOfRolls, results);

    return results;
  }

  Future<void> _saveResultsStorage(
      int totalRools, Map<String, int> result) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('total_rolls_a', totalRools);

    await prefs.setInt('dice_b_1', result['1'] ?? 0);
    await prefs.setInt('dice_b_2', result['2'] ?? 0);
    await prefs.setInt('dice_b_3', result['3'] ?? 0);
    await prefs.setInt('dice_b_4', result['4'] ?? 0);
    await prefs.setInt('dice_b_5', result['5'] ?? 0);
    await prefs.setInt('dice_b_6', result['6'] ?? 0);

    await prefs.setInt('dice_b_ganjil', result['ganjil'] ?? 0);
    await prefs.setInt('dice_b_genap', result['genap'] ?? 0);

    await prefs.setString('dice_result_b', jsonEncode(result));
  }

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
              Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2939),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Percobaan 2',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),

              const SizedBox(height: 13),

              // Instruction text
              const Text(
                'Anda bisa memilih beberapa kali percobaan yang ingin anda lakukan.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 30),

              // Option buttons
              ...options.map(
                (option) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildOptionButton(option),
                ),
              ),
              // const SizedBox(height: 30),
              // if (selectedOption != null) ...[
              //   AnimatedContainer(
              //     duration: const Duration(milliseconds: 200),
              //     curve: Curves.easeInOut,
              //     transform: hasSelection
              //         ? (Matrix4.identity()..scale(1.01))
              //         : (Matrix4.identity()..scale(1.0)),
              //     width: double.infinity,
              //     constraints: const BoxConstraints(minHeight: 0),
              //     padding: const EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFFDBEAFE),
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "FYI Dadu seimbang adalah dadu yang memiliki 6 sisi, dengan tulisan angka 1, 2, 3, 4, 5, dan 6.  Dalam setiap satu kali pelemparan dadu hanya akan muncul 1 dari 6 sisi yang ada.",
              //           style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         // SizedBox(
              //         //   height: 15,
              //         // ),
              //         // Container(
              //         //   width: 158,
              //         //   height: 68,
              //         //   alignment: Alignment.topLeft,
              //         //   padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              //         //   decoration: BoxDecoration(
              //         //     color: Colors.white,
              //         //     borderRadius: BorderRadius.circular(12),
              //         //   ),
              //         //   child: Row(
              //         //     crossAxisAlignment: CrossAxisAlignment.center,
              //         //     mainAxisAlignment: MainAxisAlignment.center,
              //         //     children: [
              //         //       Image.asset(
              //         //         'assets/image/PakRendi.png',
              //         //         width: 45,
              //         //         height: 45,
              //         //       ),
              //         //       SizedBox(
              //         //         width: 10,
              //         //       ),
              //         //       Column(
              //         //         mainAxisAlignment: MainAxisAlignment.center,
              //         //         crossAxisAlignment: CrossAxisAlignment.start,
              //         //         children: [
              //         //           Text(
              //         //             "Mr.Rendi",
              //         //             style: TextStyle(
              //         //               fontSize: 16,
              //         //               fontWeight: FontWeight.w600,
              //         //               color: Color(0xFF1F2937),
              //         //             ),
              //         //           ),
              //         //           SizedBox(
              //         //             height: 5,
              //         //           ),
              //         //           Text(
              //         //             "Math Teacher",
              //         //             style: TextStyle(
              //         //               fontSize: 11,
              //         //               fontWeight: FontWeight.w500,
              //         //               color: Color(0xFF6B7280),
              //         //             ),
              //         //           )
              //         //         ],
              //         //       )
              //         //     ],
              //         //   ),
              //         // )
              //       ],
              //     ),
              //   ),
              // ],

              const Spacer(),

              // Bottom button
              AnimatedContainer(
                height: 56,
                width: double.infinity,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                transform: hasSelection
                    ? (Matrix4.identity()..scale(1.01))
                    : (Matrix4.identity()..scale(1.0)),
                child: ElevatedButton(
                  onPressed: hasSelection
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
                          final Map<String, int> mockResults =
                              await _rollDice(numberOfRolls);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiceResultsTablePage2(
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
                    backgroundColor:
                        hasSelection ? Color(0xFF1D2939) : Color(0xFFF3F4F6),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    // selectedOption != null
                    //     ? 'Roll the dice'
                    //     : 'Choose how many times',
                    style: TextStyle(
                      fontSize: hasSelection ? 20 : 19,
                      fontWeight:
                          hasSelection ? FontWeight.w600 : FontWeight.w500,
                      color:
                          hasSelection ? Colors.white : const Color(0xFF6B7280),
                    ),
                    child: Text(
                      hasSelection ? 'Roll the dice!' : "Choose how many times",
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
          selectedOption = isSelected ? null : option;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: 53,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1F2937) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            option,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : Color(0xFF1F2937),
            ),
          ),
        ),
      ),
    );
  }
}
