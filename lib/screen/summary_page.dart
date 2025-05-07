import 'package:flutter/material.dart';
import '../screen/question.dart';

class SummaryPage extends StatelessWidget {
  final List<int?> userAnswers;

  const SummaryPage({super.key, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 20, 25, 51),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 47),
              const Text(
                'Rekap jawaban anda',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 13),
              const Text(
                'Berikut adalah benar atau salah jawaban yang diberikan untuk latihan matematika peluang berikut.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 35),
              ...List.generate(
                questions.length,
                (index) {
                  final question = questions[index];
                  final userAnswer = userAnswers[index];
                  final correctAnswer = question.correctAnswerIndex;
                  final isCorrect = userAnswer == correctAnswer;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1F2937),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IntrinsicWidth(
                              child: Center(
                                child: Text(
                                  'Soal ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? const Color(0xFFE6F4EA)
                                  : const Color(0xFFFDECEA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              isCorrect ? "Benar" : "Salah",
                              style: TextStyle(
                                color: isCorrect
                                    ? Color(0xFF2E7D32)
                                    : Color(0xFFC62828),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 13),
                      Text(
                        question.questionText,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 30),
                      ...List.generate(
                        question.options.length,
                        (i) => _buildOptionItem(
                          text: question.options[i],
                          isSelected: i == userAnswer,
                          isCorrect: i == correctAnswer,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 120),
              Container(
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/closing');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1F2937),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Finish',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildOptionItem({
    required String text,
    required bool isSelected,
    required bool isCorrect,
  }) {
    Color backgroundColor;
    Color textColor;
    FontWeight fontWeight = FontWeight.w500;
    BoxBorder? border;

    if (isSelected) {
      if (isCorrect) {
        backgroundColor = const Color(0xFF1D2939); // Hitam
        textColor = Colors.white;
        fontWeight = FontWeight.w600;
        border = null;
      } else {
        backgroundColor = const Color(0xFFFDECEA); // Merah muda
        textColor = const Color(0xFFC62828); // Merah
        fontWeight = FontWeight.w600;
        border = null;
      }
    } else if (isCorrect) {
      backgroundColor = const Color(0xFFE6F4EA); // Hijau muda
      textColor = const Color(0xFF2E7D32); // Hijau
      border = null;
    } else {
      backgroundColor = Colors.white;
      textColor = const Color(0xFF1F2937); // Abu tua
      border = Border.all(
        color: Colors.black.withOpacity(0.2),
        width: 1,
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: border,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: fontWeight,
            color: textColor,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
