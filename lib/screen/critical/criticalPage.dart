import 'package:flutter/material.dart';

class CritalPage extends StatefulWidget {
  const CritalPage({super.key});

  @override
  State<CritalPage> createState() => _CritalPageState();
}

class _CritalPageState extends State<CritalPage> {
  final List<String> texts = [
    "Kamu adalah seorang desainer yang mendesain dan memproduksi gaun pesta. Kamu menggunakan market place untuk menjual hasil produksi. Selama satu tahun terakhir kamu memproduksi gaun dengan 3 bahan berbeda, yaitu berbahan satin, sutra, dan sifon.",
    "Hasil penjualan mencatat gaun berbahan satin terjual 100 pcs, gaun berbahan sutra 50 pc, sementara untuk gaun berbaha sifon 75 pcs. Atas penjualan tersebut terdapat complain dari konsumen terkait bahan dasar yang digunakan yang meliputi complain untuk gaun berbahan satin sebanyak 15 orang, gaun berbahan sutra 8 orang, dan untuk yang berbahan sifon sebanyak 12 orang.",
    "Saat ini kamu mendapat pesanan dari konsumen prioritas dengan jumlah besar yang menginginkan kualitas terbaik (zero mistake) dari salah satu gaun yang sudah kamu buat. Menurutmu berdasarkan data penjualan yang sudah ada, gaun mana yang akan kamu rekomendasikan ke konsumen tersebut yang memiliki peluang terbaik?",
  ];

  int _visibleCount = 1;

  void _handleButtonPress() {
    if (_visibleCount < texts.length) {
      setState(() {
        _visibleCount++;
      });
    } else {
      Navigator.pushNamed(context, '/checkbox');
    }
  }

  void _removeContainer() {
    if (_visibleCount > 1) {
      setState(() {
        _visibleCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layouts
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 500;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          // Use responsive padding based on screen width
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Masalah Nyata",
                  style: TextStyle(
                    // Responsive font size
                    fontSize: isSmallScreen ? 22 : 25,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                for (int i = 0; i < _visibleCount; i++)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Column(key: ValueKey<int>(_visibleCount), children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        width: double.infinity,
                        padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBEAFE),
                          borderRadius:
                              BorderRadius.circular(isSmallScreen ? 20 : 30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (texts[i]),
                              style: TextStyle(
                                // Responsive font size
                                fontSize: isSmallScreen ? 18 : 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 25),
                            // Center user info card on small screens
                            Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  _UserInfoCard(isSmallScreen: isSmallScreen),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 75),
        child: SizedBox(
          height: 56,
          width: double.infinity,
          child: Row(
            children: [
              // OutlinedButton - Remove
              Expanded(
                child: OutlinedButton(
                  onPressed: _visibleCount > 1 ? _removeContainer : null,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: const Color(0xFF1D2939), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(isSmallScreen ? 20 : 25),
                    ),
                    foregroundColor: const Color(0xFFEF4444), // Warna teks
                  ),
                  child: SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D2939)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // ElevatedButton - Continue / Next
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleButtonPress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2939),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(isSmallScreen ? 20 : 25),
                    ),
                  ),
                  child: SizedBox(
                      height: 56,
                      child: Center(
                        child: Text(
                          _visibleCount < texts.length
                              ? 'Continue Problem'
                              : 'Next',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 15 : 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  final bool isSmallScreen;

  const _UserInfoCard({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    // Calculate responsive width
    final double cardWidth = isSmallScreen ? 180 : 210;

    return Container(
      width: cardWidth,
      height: isSmallScreen ? 60 : 68,
      padding: EdgeInsets.fromLTRB(
          10, isSmallScreen ? 2 : 4, 10, isSmallScreen ? 2 : 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/user.png',
            width: isSmallScreen ? 38 : 45,
            height: isSmallScreen ? 38 : 45,
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Linda Yang",
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              SizedBox(height: isSmallScreen ? 3 : 5),
              Text(
                "Lead Product Designer",
                style: TextStyle(
                  fontSize: isSmallScreen ? 9 : 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
