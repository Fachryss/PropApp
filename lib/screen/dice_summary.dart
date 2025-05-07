import 'dart:convert';
import 'package:flutter/material.dart';
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

  // State to track which stage we're in
  int _currentStage = 1; // 1: initial, 2: explanation, 3: question

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
    });
  }

  void _showExplanation() {
    setState(() {
      _currentStage = 2;
    });
  }

  void _goToQuestion() {
    setState(() {
      _currentStage = 3;
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Rekap seluruh percobaan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Berikut adalah tabel rekap hasil dari seluruh percobaan yang sudah dilakukan.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Table header - Peluang empiris
                    const Center(
                      child: Text(
                        'Peluang empiris',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Column headers
                    _buildTableHeader(),
                    
                    // Table content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: _experimentData.entries.map((entry) {
                            return _buildTableRow(entry.key, entry.value);
                          }).toList(),
                        ),
                      ),
                    ),
                    
                    // Show different bottom sections based on stage
                    if (_currentStage == 1)
                      _buildBottomButton(
                        'Show explanation',
                        _showExplanation,
                      ),
                    if (_currentStage == 2)
                      Column(
                        children: [
                          _buildExplanationBox(),
                          const SizedBox(height: 16),
                          _buildBottomButton(
                            'Go to question',
                            _goToQuestion,
                          ),
                        ],
                      ),
                    if (_currentStage == 3)
                      Column(
                        children: [
                          _buildQuestionBox(),
                          const SizedBox(height: 16),
                          _buildYesNoButtons(),
                        ],
                      ),
                  ],
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
                Icon(Icons.casino, size: 20, color: Colors.black54),
                const SizedBox(height: 4),
                const Text(
                  'Mata dadu',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
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
                  Icon(Icons.bar_chart, size: 20, color: Colors.black54),
                  const SizedBox(height: 4),
                  Text(
                    'Percobaan ${index + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
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
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              ...List.generate(3, (index) {
                return Expanded(
                  flex: 3,
                  child: Text(
                    values[index + 1], // Skip the first value which is frequency
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
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

  Widget _buildBottomButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D2939),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildExplanationBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Perhatikan tabel di atas, semakin banyak pelemparan dadu dilakukan peluang empiris mata dadu cenderung mengarah pada suatu nilai.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://api.placeholder.com/40/40', 
                    width: 40, 
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 24);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Mr.Rendi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Math Teacher',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Apakah peluang empiris mata dadu 1 cenderung mengarah pada nilai 1/6?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://api.placeholder.com/40/40', 
                    width: 40, 
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 24);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Mr.Rendi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Math Teacher',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYesNoButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // Handle "Ya" button press
                Navigator.pushNamed(context, '/correct_answer');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D2939),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Ya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                // Handle "Tidak" button press
                Navigator.pushNamed(context, '/incorrect_answer');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Tidak',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
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
        totalRolls += int.tryParse(resultMap['$diceValue']?.toString() ?? '0') ?? 0;
      }
      
      // Process dice values 1-6
      for (int diceValue = 1; diceValue <= 6; diceValue++) {
        // Get the actual value from the result map
        final diceCount = int.tryParse(resultMap['$diceValue']?.toString() ?? '0') ?? 0;
        
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
        final count = int.tryParse(resultMap['$diceValue']?.toString() ?? '0') ?? 0;
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