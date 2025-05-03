import 'package:flutter/material.dart';

class ExperimentSummaryPage extends StatefulWidget {
  const ExperimentSummaryPage({super.key});

  @override
  State<ExperimentSummaryPage> createState() => _ExperimentSummaryPageState();
}

class _ExperimentSummaryPageState extends State<ExperimentSummaryPage> {
  // State to track which stage we're in
  int _currentStage = 1; // 1: initial, 2: explanation, 3: question

  // Example data for the experiment results
  final Map<String, List<String>> _experimentData = {
    '1': ['15', '15/100', '15/100', '15/100'],
    '2': ['17', '17/100', '17/100', '17/100'],
    '3': ['12', '12/100', '12/100', '12/100'],
    '4': ['14', '14/100', '14/100', '14/100'],
    '5': ['21', '21/100', '21/100', '21/100'],
    '6': ['21', '21/100', '21/100', '21/100'],
    'Genap': ['52', '52/100', '52/100', '52/100'],
    'Ganjil': ['48', '48/100', '48/100', '48/100'],
  };

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
        child: Padding(
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