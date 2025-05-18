import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentImageIndex = 0;
  late Timer _timer;

  final List<String> _imagePaths = List.generate(
    8,
    (index) => 'assets/images/gambar_${index + 1}.jpg',
  );

  @override
  void initState() {
    super.initState();
    _playAudio();
    _startImageSlider();
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/intro.mp3'));
  }

  void _startImageSlider() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 51),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 71,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Masalah Nyata",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Kotak gambar slideshow
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            _imagePaths[_currentImageIndex],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Sebuah brand skincare ingin mempromosikan produk serum wajah terbarunya. '
                          'Tiga pilihan strategi tersedia: giveaway Instagram, diskon 20%, dan kolaborasi dengan beauty influencer.\n\n'
                          'Namun, anggaran hanya cukup untuk dua. Berdasarkan data sebelumnya:\n\n'
                          '- Giveaway sukses 30%\n'
                          '- Diskon sukses 50%\n'
                          '- Influencer sukses 70%\n',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _audioPlayer.stop();
                        Navigator.pushNamed(context, '/critical1');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D2939),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "Next",
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
        ),
      ),
    );
  }
}
