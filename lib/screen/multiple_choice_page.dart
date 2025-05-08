import 'dart:math';

import 'package:flutter/material.dart';
import '../screen/question.dart';
import '../screen/summary_page.dart';

class MultipleChoicePage extends StatefulWidget {
  const MultipleChoicePage({super.key});

  @override
  State<MultipleChoicePage> createState() => _MultipleChoicePageState();
}

class _MultipleChoicePageState extends State<MultipleChoicePage> {
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  bool get hasSelect => selectedAnswer != null;

  List<int?> userAnswers = List.filled(questions.length, null);

  void onSelectAnswer(int index) {
    setState(() {
      selectedAnswer = index;
      userAnswers[currentQuestionIndex] = index;
    });
  }

  void onNext() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = userAnswers[currentQuestionIndex];
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SummaryPage(userAnswers: userAnswers),
        ),
      );
    }
  }

  Widget _buildOptionButton(String option, int index) {
    final isSelected = selectedAnswer == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedAnswer = isSelected ? null : index;
          userAnswers[currentQuestionIndex] = selectedAnswer;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: 53,
        margin: const EdgeInsets.only(bottom: 10),
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
    final question = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white, // Ganti background jadi putih
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 51),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1D2939),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Soal ${currentQuestionIndex + 1}',
                style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 13),
            Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 30),
            Column(
              children: List.generate(
                question.options.length,
                (index) => _buildOptionButton(question.options[index], index),
              ),
            ),
            const Spacer(),
            AnimatedContainer(
                height: 56,
                width: double.infinity,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                transform: hasSelect
                    ? (Matrix4.identity()..scale(1.01))
                    : (Matrix4.identity()..scale(1.0)),
                // onPressed: selectedAnswer != null ? onNext : null,
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: selectedAnswer != null
                //       ? Colors.black87
                //       : Colors.grey.shade300,
                //   padding: const EdgeInsets.symmetric(vertical: 16),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                //   minimumSize: const Size.fromHeight(50),
                // ),
                child: ElevatedButton(
                  onPressed: selectedAnswer != null ? onNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        hasSelect ? Color(0xFF1D2939) : Color(0xFFF3F4F6),
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
                      fontSize: hasSelect ? 20 : 19,
                      fontWeight: hasSelect ? FontWeight.w600 : FontWeight.w500,
                      color: hasSelect ? Colors.white : const Color(0xFF6B7280),
                    ),
                    child: Text(
                      currentQuestionIndex == questions.length - 1
                          ? (selectedAnswer != null
                              ? 'Finish'
                              : 'Choose an answer')
                          : (selectedAnswer != null
                              ? 'Next question'
                              : 'Choose an answer'),
                    ),
                  ),
                )
                // Text(
                // currentQuestionIndex == questions.length - 1
                //     ? 'Selesai'
                //     : (selectedAnswer != null
                //         ? 'Next question'
                //         : 'Choose answer'),
                //   style: TextStyle(
                //     color: selectedAnswer != null ? Colors.white : Colors.black38,
                //     fontFamily: 'Poppins',
                //     fontSize: 16,
                //   ),
                // ),
                ),
            const SizedBox(height: 16),
          ],
        ),
      )),
    );
  }
}
