import 'package:flutter/material.dart';

class DiceResultsTablePage3 extends StatelessWidget {
  final int totalRolls;
  final Map<String, int> results;

  const DiceResultsTablePage3({
    super.key,
    required this.totalRolls,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total for even and odd numbers
    final int evenTotal =
        (results['2'] ?? 0) + (results['4'] ?? 0) + (results['6'] ?? 0);
    final int oddTotal =
        (results['1'] ?? 0) + (results['3'] ?? 0) + (results['5'] ?? 0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 51),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2939),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const IntrinsicWidth(
                  child: Center(
                    child: Text(
                      "Percobaan 3",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 13),

              // Description text
              const Text(
                'Berikut adalah tabel hasil percobaan lemparan dadu dengan jumlah lemparan yang dipilih.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 30),

              // Table header with icons
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.casino_outlined,
                            color: Color(0xFF1F2937), size: 24),
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
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.library_books_outlined,
                            color: Color(0xFF1F2937), size: 24),
                        const SizedBox(height: 7),
                        const Text(
                          'Frekuensi',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.auto_graph,
                            color: Color(0xFF1F2937), size: 24),
                        const SizedBox(height: 7),
                        const Text(
                          'Peluang empiris',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Table rows for each dice face
              _buildTableRow(
                  '1', results['1'] ?? 0, results['total_rolls'] ?? 0),
              _buildDivider(),
              _buildTableRow(
                  '2', results['2'] ?? 0, results['total_rolls'] ?? 0),
              _buildDivider(),
              _buildTableRow(
                  '3', results['3'] ?? 0, results['total_rolls'] ?? 0),
              _buildDivider(),
              _buildTableRow(
                  '4', results['4'] ?? 0, results['total_rolls'] ?? 0),
              _buildDivider(),
              _buildTableRow(
                  '5', results['5'] ?? 0, results['total_rolls'] ?? 0),
              _buildDivider(),
              _buildTableRow(
                  '6', results['6'] ?? 0, results['total_rolls'] ?? 0),
              _buildDivider(),

              // Summary rows (Even and Odd)
              _buildTableRow('Genap', evenTotal, totalRolls),
              _buildDivider(),
              _buildTableRow('Ganjil', oddTotal, totalRolls),

              const Spacer(),

              // Continue button
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/diceSummary');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2939),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Recap the entire experiment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

  Widget _buildTableRow(String label, int frequency, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              frequency.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$frequency/$total',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade300,
      height: 1,
    );
  }
}

// Example of how to use this page
class DiceExperimentResults extends StatelessWidget {
  const DiceExperimentResults({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data - this would normally be passed from the previous page
    final Map<String, int> mockResults = {
      '1': 15,
      '2': 17,
      '3': 12,
      '4': 14,
      '5': 21,
      '6': 21,
    };

    final int totalRolls = 100; // Example: 100 rolls

    return DiceResultsTablePage3(
      totalRolls: totalRolls,
      results: mockResults,
    );
  }
}
