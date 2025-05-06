class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

final List<Question> questions = [
  Question(
    questionText: 'Sebuah koin dilempar sekali. Peluang munculnya sisi gambar adalah ...',
    options: ['1', '0,5', '0,25', '0'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Sebuah dadu standar dilempar. Peluang muncul angka ganjil adalah ...',
    options: ['1/2', '1/3', '2/3', '1/6'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Dari huruf-huruf kata "PITA" diambil satu huruf secara acak. Peluang terambil huruf vokal adalah ...',
    options: ['1/4', '1/2', '3/4', '1'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Dari sebuah kotak berisi 5 bola merah dan 5 bola biru, diambil 1 bola. Peluang terambil bola biru adalah ...',
    options: ['1/10', '1/5', '1/2', '5/10'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Sebuah dadu dilempar. Peluang muncul bilangan prima adalah ...',
    options: ['1/2', '1/3', '2/3', '5/6'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Sebuah kartu diambil dari setumpuk kartu berisi angka 1 sampai 20. Peluang mengambil angka kelipatan 4 adalah ...',
    options: ['1/5', '1/4', '3/10', '1/2'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Sebuah kantong berisi 3 bola merah, 4 bola biru, dan 5 bola kuning. Peluang bola biru adalah ...',
    options: ['1/4', '1/3', '2/5', '1/2'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Sebuah koin dilempar dua kali. Peluang muncul minimal satu sisi gambar adalah ...',
    options: ['1/4', '1/2', '3/4', '1'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Seorang MUA punya 5 foundation (2 kering, 2 berminyak, 1 normal) dan 4 bedak. Peluang terpilih foundation kering dan bedak apapun adalah ...',
    options: ['2/5', '2/9', '1/5', '2/20'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Dalam workshop menjahit, 6 kain (2 katun, 2 satin, 2 sifon). Peluang dua kain berbahan sama adalah ...',
    options: ['1/5', '1/6', '1/3', '1/15'],
    correctAnswerIndex: 2,
  ),
];
