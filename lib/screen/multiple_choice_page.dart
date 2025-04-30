import 'dart:math';

import 'package:flutter/material.dart';

class MultipleChoicePage extends StatefulWidget {
  const MultipleChoicePage({super.key});

  @override
  State<MultipleChoicePage> createState() => _MultipleChoicePageState();
}

class _MultipleChoicePageState extends State<MultipleChoicePage> {
  String? SelecetedOption;

  bool get hasSelection => SelecetedOption != null;
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
                    color: const Color(0xFF1F2937),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const IntrinsicWidth(
                    child: Center(
                      child: Text(
                        "Soal 1",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 13,
              ),
              const Text(
                "Pertanyan yang diberikan oleh pak Rendi",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _buildOptionItem("Jawaban 1"),
              const SizedBox(
                height: 10,
              ),
              _buildOptionItem("Jawaban 2"),
              const SizedBox(
                height: 10,
              ),
              _buildOptionItem("Jawaban 3"),
              const SizedBox(
                height: 10,
              ),
              _buildOptionItem("Jawaban 4 "),
              const Spacer(),
              AnimatedContainer(
                height: 56,
                width: double.infinity,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                transform: hasSelection
                    ? (Matrix4.identity()
                      ..scale(1.01)) // Sedikit membesar saat aktif
                    : (Matrix4.identity()..scale(1.0)), // Normal
                child: ElevatedButton(
                  onPressed: hasSelection
                      ? () {
                          Navigator.pushNamed(context, '/checkbox2');
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
                      color:
                          hasSelection ? Colors.white : const Color(0xFF6B7280),
                    ),
                    child: Text(
                      hasSelection ? 'Go to next question' : "Choose an answer",
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

  Widget _buildOptionItem(String text) {
    final isSelected = SelecetedOption == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          SelecetedOption = isSelected ? null : text;
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
            text,
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
