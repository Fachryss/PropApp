import 'package:flutter/material.dart';

class KesimpulanRecap extends StatefulWidget {
  const KesimpulanRecap({super.key});

  @override
  State<KesimpulanRecap> createState() => _KesimpulanRecapState();
}

class _KesimpulanRecapState extends State<KesimpulanRecap> {
  String? selectedDropdown1;
  String? selectedDropdown2;
  bool isCorrect = false;
  bool showResult = false;

  bool get correct => isCorrect == true;

  // Opsi untuk dropdown
  final List<String> dropdownOptions = [
    'Banyaknya kejadian yang muncul',
    'Banyaknya kejadian yang tidak muncul',
    'Total semua kejadian muncul'
  ];

  // Memeriksa apakah kombinasi jawaban benar
  void checkAnswer() {
    // Kombinasi yang benar: opsi 1 (index 0) untuk dropdown1 dan opsi 3 (index 2) untuk dropdown2
    if (selectedDropdown1 == dropdownOptions[0] &&
        selectedDropdown2 == dropdownOptions[2]) {
      setState(() {
        isCorrect = true;
        showResult = true;
      });
    } else {
      setState(() {
        isCorrect = false;
        showResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kesimpulan",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Dari percobaan yang telah kita lakukan, dapat di simpulkan bahwa\n\n",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1F2937),
                              ),
                            ),

                            // Bagian yang dimodifikasi - Formula peluang empiris dengan dropdown di dalam row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Tulisan Peluang (P) empiris
                                const Text(
                                  "Peluang (P)\nempiris",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),

                                // Tanda sama dengan
                                const Text(
                                  "=",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),

                                // Column berisi dropdown1, "per", dan dropdown2
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        // Dropdown pertama
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF1F2937)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              hint: const Text(
                                                "Pilihlah jawaban anda",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF1F2937),
                                                ),
                                              ),
                                              value: selectedDropdown1,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              elevation: 16,
                                              style: const TextStyle(
                                                color: Color(0xFF1F2937),
                                                fontSize: 16,
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedDropdown1 = value;
                                                  showResult = false;
                                                });
                                              },
                                              items: dropdownOptions.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Divider(
                                          color: Colors.black,
                                          thickness: 1.2,
                                        ),

                                        const SizedBox(height: 10),

                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 11),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF1F2937)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              hint: const Text(
                                                "Pilihlah jawaban anda",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF1F2937),
                                                ),
                                              ),
                                              value: selectedDropdown2,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              elevation: 16,
                                              style: const TextStyle(
                                                color: Color(0xFF1F2937),
                                                fontSize: 16,
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedDropdown2 = value;
                                                  showResult = false;
                                                });
                                              },
                                              items: dropdownOptions.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Tombol cek jawaban
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: selectedDropdown1 != null &&
                                        selectedDropdown2 != null
                                    ? () => checkAnswer()
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1D2939),
                                  disabledBackgroundColor:
                                      const Color(0xFFCCCCCC),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Cek Jawaban",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Container hasil (hanya muncul setelah cek jawaban)
                            if (showResult)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: isCorrect
                                      ? const Color(0xFFDCFCE7)
                                      : const Color(0xFFFEE2E2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          isCorrect
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: isCorrect
                                              ? const Color(0xFF16A34A)
                                              : const Color(0xFFDC2626),
                                          size: 24,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          isCorrect
                                              ? "Tepat Sekali!"
                                              : "Belum Tepat",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: isCorrect
                                                ? const Color(0xFF16A34A)
                                                : const Color(0xFFDC2626),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      isCorrect
                                          ? "Peluang kejadian adalah perbandingan banyaknya kejadian yang diharapkan (muncul) dengan total semua kejadian yang muncul.\n\nBanyaknya kejadian yang muncul = n(A)\nTotal semua kejadiann yang muncul = n(S)"
                                          : "Coba Lagi",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Container rumus (hanya muncul jika jawaban benar)
                            if (isCorrect && showResult)
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                  top: 15,
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(60, 10, 60, 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFF1D2939)),
                                ),
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "P(A)",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                    Text(
                                      "=",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "n(A)",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1F2937),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              60, // Sesuaikan dengan kebutuhan
                                          child: Divider(
                                            color: Colors.black,
                                            thickness: 1.2,
                                          ),
                                        ),
                                        Text(
                                          "n(S)",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1F2937),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: correct
                      ? () => Navigator.pushNamed(context, '/multiple')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: correct
                        ? const Color(0xFF1D2939)
                        : const Color(0xFFF3F4F6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: correct ? 20 : 19,
                      fontWeight: correct ? FontWeight.w600 : FontWeight.w500,
                      color: correct ? Colors.white : const Color(0xFF6B7280),
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
}
