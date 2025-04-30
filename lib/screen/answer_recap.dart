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
              const SizedBox(height: 35),
              SoalRekapCard(
                soalText: "Soal 1",
                pertanyaanText: "Pertanyaan yang diberikan oleh pak Rendi",
                opsiJawaban: [
                  "Jawaban 1",
                  "Jawaban 2",
                  "Jawaban 3",
                  "Jawaban 4"
                ],
                jawabanDipilih: "Jawaban 2",
                jawabanBenar: "Jawaban 3",
              ),
              SizedBox(
                height: 35,
              ),
              SoalRekapCard(
                soalText: "Soal 2",
                pertanyaanText: "Pertanyaan yang diberikan oleh pak Rendi",
                opsiJawaban: [
                  "Jawaban 1",
                  "Jawaban 2",
                  "Jawaban 3",
                  "Jawaban 4"
                ],
                jawabanDipilih: "Jawaban 3",
                jawabanBenar: "Jawaban 3",
              ),
              SizedBox(
                height: 35,
              ),
              SoalRekapCard(
                soalText: "Soal 3",
                pertanyaanText: "Pertanyaan yang diberikan oleh pak Rendi",
                opsiJawaban: [
                  "Jawaban 1",
                  "Jawaban 2",
                  "Jawaban 3",
                  "Jawaban 4"
                ],
                jawabanDipilih: "",
                jawabanBenar: "Jawaban 3",
              ),
              const SizedBox(
                height: 50,
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

class SoalRekapCard extends StatelessWidget {
  final String soalText;
  final String pertanyaanText;
  final List<String> opsiJawaban;
  final String jawabanDipilih;
  final String jawabanBenar;

  const SoalRekapCard({
    super.key,
    required this.soalText,
    required this.pertanyaanText,
    required this.opsiJawaban,
    required this.jawabanDipilih,
    required this.jawabanBenar,
  });

  @override
  Widget build(BuildContext context) {
    bool isBenar = jawabanDipilih == jawabanBenar;

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
                      soalText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              decoration: BoxDecoration(
                color:
                    isBenar ? const Color(0xFFE6F4EA) : const Color(0xFFFDECEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isBenar ? "Benar" : "Salah",
                style: TextStyle(
                  color: isBenar ? Color(0xFF2E7D32) : Color(0xFFC62828),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Text(
          pertanyaanText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 30),
        Column(
          children: opsiJawaban.map((option) {
            return _buildOptionItem(option);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOptionItem(String text) {
    bool isSelected = text == jawabanDipilih;
    bool isCorrect = text == jawabanBenar;

    Color backgroundColor;
    Color textColor;
    FontWeight fontWeight = FontWeight.w500;
    BoxBorder? border;

    if (isSelected) {
      if (isCorrect) {
        backgroundColor = const Color(0xFF1D2939); // Hijau muda
        textColor = Colors.white;
        fontWeight = FontWeight.w600;
        border = null; // Tidak ada border
      } else {
        backgroundColor = const Color(0xFFFDECEA); // Merah muda
        textColor = const Color(0xFFC62828);
        fontWeight = FontWeight.w600;
        border = null; // Tidak ada border
      }
    } else if (isCorrect) {
      backgroundColor = const Color(0xFFE6F4EA); // Hijau muda
      textColor = const Color(0xFF2E7D32);
      border = null; // Tidak ada border
    } else {
      backgroundColor = Colors.white;
      textColor = const Color(0xFF1F2937);
      border = Border.all(
        color: Colors.black.withOpacity(0.2),
        width: 1,
      ); // Border tipis kalau bukan jawaban apapun
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
            fontSize: 18,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
