import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:propapp/screen/dice_table_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiceExperimentPage1 extends StatefulWidget {
  const DiceExperimentPage1({super.key});

  @override
  State<DiceExperimentPage1> createState() => _DiceExperimentPage1State();
}

class _DiceExperimentPage1State extends State<DiceExperimentPage1> with TickerProviderStateMixin {
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
        results['genap'] = (results['genap'] ?? 0) + 1;
      } else {
        results['genap'] = (results['genap'] ?? 0) + 1;
      } else {
        results['ganjil'] = (results['ganjil'] ?? 0) + 1;
      }
    }

    await _saveResultsStorage(numberOfRolls, results);

    return results;
  }

  Future<void> _saveResultsStorage(int totalRools, Map<String, int> result) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('total_rolls_a', totalRools);

    for (int i = 1; i <= 6; i++) {
      await prefs.setInt('dice_a_$i', result['$i'] ?? 0);
    }

    await prefs.setInt('dice_a_ganjil', result['ganjil'] ?? 0);
    await prefs.setInt('dice_a_genap', result['genap'] ?? 0);
    await prefs.setString('dice_result_a', jsonEncode(result));
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
          color: isSelected ? const Color(0xFF1F2937) : Colors.white,
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
              color: isSelected ? Colors.white : const Color(0xFF1F2937),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D2939),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Percobaan 1',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 13),
                      const Text(
                        'Anda bisa memilih beberapa kali percobaan yang ingin anda lakukan.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ...options.map(
                        (option) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildOptionButton(option),
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (hasSelection)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          transform: Matrix4.identity()..scale(1.01),
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBEAFE),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "FYI Dadu seimbang adalah dadu yang memiliki 6 sisi, dengan tulisan angka 1, 2, 3, 4, 5, dan 6. Dalam setiap satu kali pelemparan dadu hanya akan muncul 1 dari 6 sisi yang ada.",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                width: 158,
                                height: 68,
                                padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/PakRendi.png',
                                      width: 45,
                                      height: 45,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Mr.Rendi",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1F2937),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Math Teacher",
                                          style: TextStyle(
                                            fontSize: 11,
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
                      const SizedBox(height: 30),
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
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );

                                  final Map<String, int> mockResults =
                                      await _rollDice(numberOfRolls);

                                  if (context.mounted) {
                                    Navigator.pop(context); // close dialog
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DiceResultsTablePage1(
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
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: hasSelection
                                ? const Color(0xFF1D2939)
                                : const Color(0xFFF3F4F6),
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
          },
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

