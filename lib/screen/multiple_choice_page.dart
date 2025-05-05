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

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white, // Ganti background jadi putih
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            25, 48, 25, 16), // Tambahkan top padding untuk pengganti AppBar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Soal ${currentQuestionIndex + 1}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < question.options.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => onSelectAnswer(i),
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          selectedAnswer == i ? Colors.black87 : Colors.white,
                      foregroundColor:
                          selectedAnswer == i ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Colors.black12),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(question.options[i]),
                  ),
                ),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedAnswer != null ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedAnswer != null
                    ? Colors.black87
                    : Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text(
                currentQuestionIndex == questions.length - 1
                    ? 'Selesai'
                    : (selectedAnswer != null
                        ? 'Next question'
                        : 'Choose answer'),
                style: TextStyle(
                  color: selectedAnswer != null ? Colors.white : Colors.black38,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
