import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// Class untuk mengelola gambar dengan waktu tampil
class TimedImage {
  final int timeInSeconds;
  final String imagePath;

  TimedImage({
    required this.timeInSeconds,
    required this.imagePath,
  });
}

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentImageIndex = 0;
  late Timer _timer;
  int _elapsedTimeInSeconds = 0;

  // Daftar gambar dengan waktu tayang masing-masing
  final List<TimedImage> _timedImages = [
    TimedImage(
        timeInSeconds: 0, imagePath: 'assets/images/gambar_9.jpg'), // Intro
    TimedImage(
        timeInSeconds: 7, imagePath: 'assets/images/gambar_1.jpg'), // Skincare
    TimedImage(
        timeInSeconds: 16,
        imagePath: 'assets/images/gambar_2.jpg'), // serum wajah
    TimedImage(
        timeInSeconds: 21, imagePath: 'assets/images/gambar_6.jpg'), // tanya
    TimedImage(
        timeInSeconds: 34,
        imagePath: 'assets/images/gambar_4.jpg'), // giveaway Instagram
    TimedImage(
        timeInSeconds: 37,
        imagePath: 'assets/images/gambar_3.jpg'), // diskon 20%
    TimedImage(
        timeInSeconds: 41,
        imagePath: 'assets/images/gambar_5.jpg'), // kolaborasi influencer
    TimedImage(
        timeInSeconds: 45, imagePath: 'assets/images/gambar_10.jpg'), // peluang
    TimedImage(timeInSeconds: 89, imagePath: 'assets/images/gambar_3.jpg'),
    TimedImage(timeInSeconds: 91, imagePath: 'assets/images/gambar_5.jpg'),
    TimedImage(timeInSeconds: 97, imagePath: 'assets/images/gambar_7.jpg'),
    TimedImage(timeInSeconds: 105, imagePath: 'assets/images/gambar_8.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    _playAudio();
    _startTimedImageDisplay();
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/intro.mp3'));
  }

  void _startTimedImageDisplay() {
    // Buat timer yang menjalankan pengecekan setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Tambah hitungan waktu
        _elapsedTimeInSeconds++;

        // Cek apakah perlu mengganti gambar
        for (int i = 0; i < _timedImages.length; i++) {
          // Cari gambar yang seharusnya ditampilkan pada waktu saat ini
          if (_elapsedTimeInSeconds >= _timedImages[i].timeInSeconds &&
              (i == _timedImages.length - 1 ||
                  _elapsedTimeInSeconds < _timedImages[i + 1].timeInSeconds)) {
            if (_currentImageIndex != i) {
              _currentImageIndex = i;
              break;
            }
          }
        }
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
                        // Kotak gambar dengan sistem waktu
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            _timedImages[_currentImageIndex].imagePath,
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
