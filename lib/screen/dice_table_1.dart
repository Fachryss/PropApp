import 'dart:async';

import 'package:flutter/material.dart';

class DiceResultsTablePage1 extends StatefulWidget {
  final int totalRolls;
  final Map<String, int> results;

  const DiceResultsTablePage1({
    super.key,
    required this.totalRolls,
    required this.results,
  });

  @override
  _DiceResultsTablePage1State createState() => _DiceResultsTablePage1State();
}

class _DiceResultsTablePage1State extends State<DiceResultsTablePage1> {
  String currentText =
      "Peluang empiris adalah perbandingan banyaknya kejadian yang muncul dengan banyak percobaan yang dilakukan.";

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 15), () {
      if (mounted) {
        setState(() {
          currentText =
              "Kolom frekuensi berisi hasil random muncul mata dadu masing-masing, peluang empiris berisi nilai frekuensi dibagi dengan total pelemparan yang dipilih.";
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int evenTotal = (widget.results['2'] ?? 0) +
        (widget.results['4'] ?? 0) +
        (widget.results['6'] ?? 0);
    final int oddTotal = (widget.results['1'] ?? 0) +
        (widget.results['3'] ?? 0) +
        (widget.results['5'] ?? 0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 51),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 53),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2939),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const IntrinsicWidth(
                  child: Center(
                    child: Text(
                      "Percobaan 1",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              const Text(
                'Berikut adalah tabel hasil percobaan lemparan dadu dengan jumlah lemparan yang dipilih.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 30),
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
                              fontWeight: FontWeight.w600),
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
                              fontWeight: FontWeight.w600),
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
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildTableRow('1', widget.results['1'] ?? 0, widget.totalRolls),
              _buildDivider(),
              _buildTableRow('2', widget.results['2'] ?? 0, widget.totalRolls),
              _buildDivider(),
              _buildTableRow('3', widget.results['3'] ?? 0, widget.totalRolls),
              _buildDivider(),
              _buildTableRow('4', widget.results['4'] ?? 0, widget.totalRolls),
              _buildDivider(),
              _buildTableRow('5', widget.results['5'] ?? 0, widget.totalRolls),
              _buildDivider(),
              _buildTableRow('6', widget.results['6'] ?? 0, widget.totalRolls),
              _buildDivider(),
              _buildTableRow('Genap', evenTotal, widget.totalRolls),
              _buildDivider(),
              _buildTableRow('Ganjil', oddTotal, widget.totalRolls),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: 0,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937),
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
                            "assets/images/PakRendi.png",
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 63),
              Container(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dice2');
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
                    'Continue Test 2',
                    style: TextStyle(
                      fontSize: 20,
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
