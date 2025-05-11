import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:propapp/screen/dice_table_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiceExperimentPage1 extends StatefulWidget {
  const DiceExperimentPage1({super.key});

  @override
  State<DiceExperimentPage1> createState() => _DiceExperimentPageState();
}

class _DiceExperimentPageState extends State<DiceExperimentPage1>
    with TickerProviderStateMixin {
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

  // Property to control GIF speed - can be adjusted as needed
  double gifSpeed = 1.5; // Slightly faster than default for better visual

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
        results['genap'] = (results['genap'] ?? 0) + 1;
      } else {
        results['ganjil'] = (results['ganjil'] ?? 0) + 1;
      }
    }

    await _saveResultsStorage(numberOfRolls, results);

    return results;
  }

  Future<void> _saveResultsStorage(
      int totalRools, Map<String, int> result) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('total_rolls_a', totalRools);

    await prefs.setInt('dice_a_1', result['1'] ?? 0);
    await prefs.setInt('dice_a_2', result['2'] ?? 0);
    await prefs.setInt('dice_a_3', result['3'] ?? 0);
    await prefs.setInt('dice_a_4', result['4'] ?? 0);
    await prefs.setInt('dice_a_5', result['5'] ?? 0);
    await prefs.setInt('dice_a_6', result['6'] ?? 0);

    await prefs.setInt('dice_a_ganjil', result['ganjil'] ?? 0);
    await prefs.setInt('dice_a_genap', result['genap'] ?? 0);

    await prefs.setString('dice_result_a', jsonEncode(result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    'Percobaan 1',
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
                const SizedBox(height: 30),
                if (selectedOption != null) ...[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    transform: hasSelection
                        ? (Matrix4.identity()..scale(1.01))
                        : (Matrix4.identity()..scale(1.0)),
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 0),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FYI Dadu seimbang adalah dadu yang memiliki 6 sisi, dengan tulisan angka 1, 2, 3, 4, 5, dan 6.  Dalam setiap satu kali pelemparan dadu hanya akan muncul 1 dari 6 sisi yang ada.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 158,
                          height: 68,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/PakRendi.png',
                                width: 45,
                                height: 45,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mr.Rendi",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    "Math Teacher",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF6B7280),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],

                const SizedBox(
                  height: 30,
                ),

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

                            // Show custom loading dialog with SpeedControlledGif
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Using the SpeedControlledGif widget with customizable speed
                                        SpeedControlledGif(
                                          assetPath: 'assets/images/dadu.gif',
                                          speed:
                                              gifSpeed, // Use the class property for speed control
                                          width: 200,
                                          height: 200,
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            "Rolling dice...",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1D2939),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            // Process dice rolls
                            final Map<String, int> results =
                                await _rollDice(numberOfRolls);

                            // Ensure the loading animation shows for at least 4 seconds
                            await Future.delayed(const Duration(seconds: 6));

                            // Navigate to results page
                            Navigator.pop(context); // Close loading dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DiceResultsTablePage1(
                                  totalRolls: numberOfRolls,
                                  results: {
                                    '1': results['1'] ?? 0,
                                    '2': results['2'] ?? 0,
                                    '3': results['3'] ?? 0,
                                    '4': results['4'] ?? 0,
                                    '5': results['5'] ?? 0,
                                    '6': results['6'] ?? 0,
                                    'ganjil': results['ganjil'] ?? 0,
                                    'genap': results['genap'] ?? 0,
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
                      style: TextStyle(
                        fontSize: hasSelection ? 20 : 19,
                        fontWeight:
                            hasSelection ? FontWeight.w600 : FontWeight.w500,
                        color: hasSelection
                            ? Colors.white
                            : const Color(0xFF6B7280),
                      ),
                      child: Text(
                        hasSelection
                            ? 'Roll the dice!'
                            : "Choose how many times",
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

// Implemented speed-controlled GIF widget for better animation control
class SpeedControlledGif extends StatefulWidget {
  final String assetPath;
  final double speed;
  final double width;
  final double height;

  const SpeedControlledGif({
    Key? key,
    required this.assetPath,
    this.speed = 1.0,
    this.width = 150,
    this.height = 150,
  }) : super(key: key);

  @override
  State<SpeedControlledGif> createState() => _SpeedControlledGifState();
}

class _SpeedControlledGifState extends State<SpeedControlledGif>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // Start the animation with the specified speed
    _controller.repeat(
        period: Duration(milliseconds: (1000 / widget.speed).round()));
  }

  @override
  void didUpdateWidget(SpeedControlledGif oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.speed != widget.speed) {
      _controller.repeat(
          period: Duration(milliseconds: (1000 / widget.speed).round()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: Image.asset(
            widget.assetPath,
            gaplessPlayback: true,
            // Use frameBuilder to add additional animation effects if needed
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              // The frame parameter gives us information about which frame of the animation is currently showing
              return child;
            },
          ),
        );
      },
    );
  }
}
