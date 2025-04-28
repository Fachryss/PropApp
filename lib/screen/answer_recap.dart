import 'package:flutter/material.dart';

class AnswerRecap extends StatefulWidget {
  const AnswerRecap({super.key});

  @override
  State<AnswerRecap> createState() => _AnswerRecapState();
}

class _AnswerRecapState extends State<AnswerRecap> {
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
                ),
              ),
              const SizedBox(height: 13),
              const Text(
                'Berikut adalah benar atau salah jawaban yang diberikan untuk latihan matematika peluang berikut.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              Container(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkbox2');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1D2939),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    "Finish",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
