import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:propapp/screen/Kesimpulan_recap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExperimentSummaryPage extends StatefulWidget {
  const ExperimentSummaryPage({super.key});

  @override
  State<ExperimentSummaryPage> createState() => _ExperimentSummaryPageState();
}

class _ExperimentSummaryPageState extends State<ExperimentSummaryPage> {
  late SharedPreferences prefs;
  late Map<String, List<String>> _experimentData;
  bool _isLoading = true;

  // State variables for questions
  int _currentQuestionIndex =
      0; // 0: no question, 1: first question, 2: second question
  String? _selectedAnswer;
  bool _showFeedback = false;
  bool _isAnswerCorrect = false;

  // Define questions data structure
  final List<QuestionData> _questions = [
    QuestionData(
      questionText:
          '1. Apakah peluang empiris mata dadu 1 cenderung mengarah pada nilai 1/6?',
      correctAnswer: '1/6',
      successFeedback: 'Tepat Sekali, peluang munculnya angka 1 adalah 1/6.',
      failureFeedback:
          'Coba perhatikan kembali tabel, terlihat bahwa peluang empiris benar mendekati nilai 1/6!',
    ),
    QuestionData(
      questionText:
          '2. Bagaimana dengan peluang mata dadu genap (mata dadu 2, 4, dan 6)? Apakah mengarah pada nilai tertentu? Berapa',
      correctAnswer: '3/6',
      successFeedback:
          'Tepat Sekali, peluang munculnya mata dadu genap adalah 3/6.',
      failureFeedback:
          'Coba perhatikan kembali tabel, khusunya pada peluang empiris mata dadu genap yang mengarah pada nilai tertentu yaitu 3/6.',
    ),
    QuestionData(
      questionText:
          '3. Bagaimana dengan mata dadu 2, mengarah pada angka berapa peluang empirisnya?',
      correctAnswer: '1/6',
      successFeedback:
          'Tepat Sekali, peluang munculnya mata dadu 2 adalah 1/6.',
      failureFeedback:
          'Coba perhatikan kembali tabel, khusunya pada peluang empiris mata dadu 2 yang mengarah pada nilai tertentu yaitu 1/6.',
    ),
    QuestionData(
      questionText:
          '4. Bagaimana dengan peluang munculnya mata dadu yang lain seperti munculnya mata dadu 3, mata dadu 4, mata dadu 5, dan mata dadu 6? Apakah juga mengarah pada nilai 1/6?',
      correctAnswer: 'Ya',
      successFeedback:
          'Tepat Sekali, peluang munculnya suatu kejadian (muncul 1 sisi mata dadu) adalah 1/6.',
      failureFeedback:
          'Coba perhatikan kembali tabel, terlihat bahwa peluang empiris benar mendekati nilai 1/6!',
    ),
    QuestionData(
      questionText:
          '5. Bagaimana dengan peluang mata dadu ganjil (mata dadu 1, 3, dan 5)? Apakah juga mengarah pada nilai tertentu? Berapa',
      correctAnswer: '3/6',
      successFeedback:
          'Tepat Sekali, peluang munculnya mata dadu ganjil adalah 3/6.',
      failureFeedback:
          'Coba perhatikan kembali tabel, khusunya pada peluang empiris mata dadu ganjil yang mengarah pada nilai tertentu yaitu 3/6.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    prefs = await SharedPreferences.getInstance();
    final fetchedData = await DiceDataManager.fetchExperimentData();

    setState(() {
      _experimentData = fetchedData;
      _isLoading = false;
      _currentQuestionIndex = 1; // Start with the first question
    });
  }

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _showFeedback = true;

      // Get current question (subtract 1 from index since questions array is 0-based)
      final currentQuestion = _questions[_currentQuestionIndex - 1];

      // For question 4, handle "Ya" answer specially
      if (_currentQuestionIndex == 4) {
        _isAnswerCorrect = answer == "Ya";
      } else {
        _isAnswerCorrect = answer == currentQuestion.correctAnswer;
      }
    });
  }

  void _goToNextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _showFeedback = false;
    });
  }

  void _finishExperiment() {
    // Navigate to conclusion page
    // For now, we'll just show a dialog as a placeholder
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Selesai!"),
        content: Text(
            "Anda telah menyelesaikan semua pertanyaan. Terima kasih!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/multiple');
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _retryQuestion() {
    setState(() {
      _showFeedback = false;
      _selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 51),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Rekap seluruh percobaan',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 13),
                      const Text(
                        'Berikut adalah tabel rekap hasil dari seluruh percobaan yang sudah dilakukan.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Center(
                        child: Text(
                          'Peluang empiris',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tabel header
                      _buildTableHeader(),
                      const SizedBox(height: 8),

                      // Tabel isi
                      Column(
                        children: _experimentData.entries.map((entry) {
                          return _buildTableRow(entry.key, entry.value);
                        }).toList(),
                      ),

                      // Questions section
                      if (_currentQuestionIndex > 0 &&
                          _currentQuestionIndex <= _questions.length)
                        QuestionWidget(
                          questionData: _questions[_currentQuestionIndex - 1],
                          selectedAnswer: _selectedAnswer,
                          showFeedback: _showFeedback,
                          isAnswerCorrect: _isAnswerCorrect,
                          onSelectAnswer: _selectAnswer,
                          onRetry: _retryQuestion,
                          onNext: _currentQuestionIndex < _questions.length
                              ? _goToNextQuestion
                              : _finishExperiment,
                          nextButtonText:
                              _currentQuestionIndex < _questions.length
                                  ? 'Lanjut'
                                  : 'Selesai',
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Icon(
                  Icons.casino_outlined,
                  size: 24,
                  color: Color(0xFF1F2937),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Mata dadu',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ),
        ...List.generate(3, (index) {
          return Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Icon(Icons.bar_chart_outlined,
                      size: 24, color: Color(0xFF1F2937)),
                  const SizedBox(height: 7),
                  Text(
                    'Percobaan ${index + 1}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTableRow(String label, List<String> values) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey.shade300),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              ...List.generate(3, (index) {
                return Expanded(
                  flex: 3,
                  child: Text(
                    values[
                        index + 1], // Skip the first value which is frequency
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

// Data model for questions
class QuestionData {
  final String questionText;
  final String correctAnswer;
  final String successFeedback;
  final String failureFeedback;

  QuestionData({
    required this.questionText,
    required this.correctAnswer,
    required this.successFeedback,
    required this.failureFeedback,
  });
}

// Reusable question widget
class QuestionWidget extends StatelessWidget {
  final QuestionData questionData;
  final String? selectedAnswer;
  final bool showFeedback;
  final bool isAnswerCorrect;
  final Function(String) onSelectAnswer;
  final VoidCallback onRetry;
  final VoidCallback onNext;
  final String nextButtonText;

  const QuestionWidget({
    super.key,
    required this.questionData,
    required this.selectedAnswer,
    required this.showFeedback,
    required this.isAnswerCorrect,
    required this.onSelectAnswer,
    required this.onRetry,
    required this.onNext,
    required this.nextButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 35),

        // Question box
        QuestionBox(text: questionData.questionText),

        const SizedBox(height: 35),

        // Feedback or Answer options
        if (showFeedback)
          FeedbackBox(
            isAnswerCorrect: isAnswerCorrect,
            feedbackText: isAnswerCorrect
                ? questionData.successFeedback
                : questionData.failureFeedback,
            buttonText: isAnswerCorrect ? nextButtonText : 'Coba Lagi',
            onButtonPressed: isAnswerCorrect ? onNext : onRetry,
          )
        else
          AnswerOptions(onSelectAnswer: onSelectAnswer),
      ],
    );
  }
}

// Question box component
class QuestionBox extends StatelessWidget {
  final String text;

  const QuestionBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 25),
          TeacherInfoRow(),
        ],
      ),
    );
  }
}

// Teacher info component
class TeacherInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

// Feedback box component
class FeedbackBox extends StatelessWidget {
  final bool isAnswerCorrect;
  final String feedbackText;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const FeedbackBox({
    super.key,
    required this.isAnswerCorrect,
    required this.feedbackText,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isAnswerCorrect ? Color(0xFFE6F4EA) : Color(0xFFFDECEA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isAnswerCorrect ? Color(0xFF2E7D32) : Color(0xFFC62828),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isAnswerCorrect
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isAnswerCorrect ? Icons.check : Icons.close,
                      color: isAnswerCorrect
                          ? Color(0xFF2E7D32)
                          : Color(0xFFC62828),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isAnswerCorrect ? 'Tepat Sekali!' : 'Belum Tepat',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: isAnswerCorrect
                          ? Color(0xFF2E7D32)
                          : Color(0xFFC62828),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                feedbackText,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1D2939),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Answer options component
class AnswerOptions extends StatelessWidget {
  final Function(String) onSelectAnswer;

  const AnswerOptions({
    super.key,
    required this.onSelectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current question index from the closest StatefulWidget
    final _ExperimentSummaryPageState state =
        context.findAncestorStateOfType<_ExperimentSummaryPageState>()!;

    // For question 4, we show Yes/No options
    if (state._currentQuestionIndex == 4) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildAnswerButton("Ya"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAnswerButton("Tidak"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'choose an answer',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      );
    }

    // For other questions, show fraction options
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAnswerButton("1/6"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildAnswerButton("2/6"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildAnswerButton("3/6"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildAnswerButton("4/6"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildAnswerButton("5/6"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildAnswerButton("6/6"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'choose an answer',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerButton(String text) {
    return SizedBox(
      height: 53,
      child: OutlinedButton(
        onPressed: () => onSelectAnswer(text),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: const Color(0xFF1F2937),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Class to handle fetching data from SharedPreferences
class DiceDataManager {
  // Fetch data from SharedPreferences and organize it into the desired format
  static Future<Map<String, List<String>>> fetchExperimentData() async {
    final prefs = await SharedPreferences.getInstance();

    // Define expected pages
    final pages = ['a', 'b', 'c'];

    // Initialize result map
    final Map<String, List<String>> experimentData = {
      '1': ['0', '0/0', '0/0', '0/0'],
      '2': ['0', '0/0', '0/0', '0/0'],
      '3': ['0', '0/0', '0/0', '0/0'],
      '4': ['0', '0/0', '0/0', '0/0'],
      '5': ['0', '0/0', '0/0', '0/0'],
      '6': ['0', '0/0', '0/0', '0/0'],
      'Genap': ['0', '0/0', '0/0', '0/0'],
      'Ganjil': ['0', '0/0', '0/0', '0/0'],
    };

    // Populate data from available pages
    for (int i = 0; i < pages.length; i++) {
      final page = pages[i];
      final columnIndex = i + 1; // 1-based index for columns (1, 2, 3)

      // Get total rolls for this page
      final resultKey = 'dice_result_$page';
      final resultValue = prefs.getString(resultKey) ?? '{}';
      Map<String, dynamic> resultMap;

      try {
        resultMap = jsonDecode(resultValue) as Map<String, dynamic>;
      } catch (e) {
        resultMap = {};
      }

      // Calculate total rolls for this page
      int totalRolls = 0;
      for (int diceValue = 1; diceValue <= 6; diceValue++) {
        totalRolls +=
            int.tryParse(resultMap['$diceValue']?.toString() ?? '0') ?? 0;
      }

      // Process dice values 1-6
      for (int diceValue = 1; diceValue <= 6; diceValue++) {
        // Get the actual value from the result map
        final diceCount =
            int.tryParse(resultMap['$diceValue']?.toString() ?? '0') ?? 0;

        // Update the raw count in the first column (only for the first page)
        if (page == 'a') {
          experimentData['$diceValue']![0] = diceCount.toString();
        }

        // Update the fraction in the appropriate column
        if (totalRolls > 0) {
          experimentData['$diceValue']![columnIndex] = '$diceCount/$totalRolls';
        } else {
          experimentData['$diceValue']![columnIndex] = '0/0';
        }
      }

      // Calculate odd and even counts
      int oddCount = 0;
      int evenCount = 0;

      for (int diceValue = 1; diceValue <= 6; diceValue++) {
        final count =
            int.tryParse(resultMap['$diceValue']?.toString() ?? '0') ?? 0;
        if (diceValue % 2 == 0) {
          evenCount += count;
        } else {
          oddCount += count;
        }
      }

      // Update raw counts for first page
      if (page == 'a') {
        experimentData['Ganjil']![0] = oddCount.toString();
        experimentData['Genap']![0] = evenCount.toString();
      }

      // Update odd/even ratios
      if (totalRolls > 0) {
        experimentData['Ganjil']![columnIndex] = '$oddCount/$totalRolls';
        experimentData['Genap']![columnIndex] = '$evenCount/$totalRolls';
      } else {
        experimentData['Ganjil']![columnIndex] = '0/0';
        experimentData['Genap']![columnIndex] = '0/0';
      }
    }

    return experimentData;
  }
}
