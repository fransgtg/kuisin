import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';

/// Data dummy lokal (tanpa database).
class QuestionBank {
  QuestionBank._();

  static const List<QuizCategory> categories = [
    QuizCategory(
      id: 'umum',
      title: 'Pengetahuan Umum',
      description: 'Geografi, sejarah, dan budaya',
      icon: Icons.public_rounded,
      color: AppColors.secondary,
      questions: [
        Question(
          text: 'Apa ibu kota provinsi Jawa Barat?',
          options: ['Bandung', 'Bogor', 'Bekasi', 'Cirebon'],
          correctIndex: 0,
          explanation: 'Bandung adalah ibu kota provinsi Jawa Barat.',
        ),
        Question(
          text: 'Kapan Indonesia memproklamasikan kemerdekaan?',
          options: [
            '17 Agustus 1945',
            '20 Mei 1908',
            '28 Oktober 1928',
            '1 Juni 1945',
          ],
          correctIndex: 0,
          explanation:
              'Proklamasi dibacakan oleh Soekarno–Hatta pada 17 Agustus 1945.',
        ),
        Question(
          text: 'Danau terbesar di Indonesia adalah...',
          options: [
            'Danau Toba',
            'Danau Maninjau',
            'Danau Poso',
            'Danau Sentani',
          ],
          correctIndex: 0,
          explanation: 'Danau Toba di Sumatera Utara merupakan danau vulkanik terbesar di Indonesia.',
        ),
        Question(
          text: 'Candi Borobudur terletak di provinsi...',
          options: ['Jawa Tengah', 'DI Yogyakarta', 'Jawa Timur', 'Bali'],
          correctIndex: 0,
          explanation: 'Borobudur berada di Magelang, Jawa Tengah.',
        ),
        Question(
          text: 'Mata uang resmi Jepang adalah...',
          options: ['Won', 'Yuan', 'Yen', 'Ringgit'],
          correctIndex: 2,
          explanation: 'Yen (¥) adalah mata uang resmi Jepang.',
        ),
        Question(
          text: 'Gunung tertinggi di Indonesia adalah...',
          options: ['Semeru', 'Rinjani', 'Kerinci', 'Puncak Jaya'],
          correctIndex: 3,
          explanation: 'Puncak Jaya (Carstensz Pyramid) di Papua memiliki tinggi sekitar 4.884 mdpl.',
        ),
        Question(
          text: 'Alat musik angklung berasal dari daerah...',
          options: ['Jawa Barat', 'Sumatera Barat', 'Bali', 'Sulawesi Selatan'],
          correctIndex: 0,
          explanation: 'Angklung adalah alat musik bambu khas Sunda (Jawa Barat) yang diakui UNESCO.',
        ),
        Question(
          text: 'Samudra terluas di dunia adalah...',
          options: ['Atlantik', 'Hindia', 'Arktik', 'Pasifik'],
          correctIndex: 3,
          explanation:
              'Samudra Pasifik menutupi sekitar sepertiga permukaan Bumi.',
        ),
      ],
    ),
    QuizCategory(
      id: 'sains',
      title: 'Sains',
      description: 'Fisika, kimia, biologi, dan astronomi',
      icon: Icons.science_rounded,
      color: AppColors.success,
      questions: [
        Question(
          text: 'Planet terbesar di tata surya adalah...',
          options: ['Saturnus', 'Jupiter', 'Neptunus', 'Bumi'],
          correctIndex: 1,
          explanation:
              'Jupiter adalah planet terbesar, sekitar 11 kali diameter Bumi.',
        ),
        Question(
          text: 'Rumus kimia air adalah...',
          options: ['CO₂', 'H₂O', 'O₂', 'NaCl'],
          correctIndex: 1,
          explanation: 'Satu molekul air terdiri dari 2 atom hidrogen dan 1 atom oksigen.',
        ),
        Question(
          text: 'Organ yang memompa darah ke seluruh tubuh adalah...',
          options: ['Paru-paru', 'Hati', 'Jantung', 'Ginjal'],
          correctIndex: 2,
          explanation: 'Jantung memompa darah melalui sistem peredaran darah.',
        ),
        Question(
          text: 'Satuan SI untuk gaya adalah...',
          options: ['Joule', 'Watt', 'Pascal', 'Newton'],
          correctIndex: 3,
          explanation: 'Gaya diukur dalam Newton (N), yaitu kg·m/s².',
        ),
        Question(
          text: 'Proses tumbuhan membuat makanan dengan bantuan cahaya matahari disebut...',
          options: ['Respirasi', 'Fotosintesis', 'Transpirasi', 'Evaporasi'],
          correctIndex: 1,
          explanation: 'Fotosintesis mengubah CO₂ dan air menjadi glukosa dengan energi cahaya.',
        ),
        Question(
          text: 'Gas yang paling banyak di atmosfer Bumi adalah...',
          options: ['Oksigen', 'Karbon dioksida', 'Nitrogen', 'Argon'],
          correctIndex: 2,
          explanation: 'Nitrogen menyusun sekitar 78% atmosfer Bumi.',
        ),
        Question(
          text: 'Kecepatan cahaya di ruang hampa kira-kira...',
          options: [
            '300.000 km/detik',
            '30.000 km/detik',
            '3.000 km/detik',
            '340 m/detik',
          ],
          correctIndex: 0,
          explanation:
              'Cahaya merambat sekitar 299.792 km per detik di ruang hampa.',
        ),
        Question(
          text: 'Planet yang dijuluki "Planet Merah" adalah...',
          options: ['Venus', 'Merkurius', 'Mars', 'Uranus'],
          correctIndex: 2,
          explanation:
              'Mars tampak merah karena permukaannya kaya oksida besi.',
        ),
      ],
    ),
    QuizCategory(
      id: 'teknologi',
      title: 'Teknologi',
      description: 'Komputer, internet, dan perangkat digital',
      icon: Icons.memory_rounded,
      color: AppColors.primary,
      questions: [
        Question(
          text: 'Kepanjangan dari CPU adalah...',
          options: [
            'Central Processing Unit',
            'Computer Personal Unit',
            'Central Program Utility',
            'Control Processing Unit',
          ],
          correctIndex: 0,
          explanation:
              'CPU (Central Processing Unit) adalah otak pemrosesan komputer.',
        ),
        Question(
          text: 'Bahasa yang digunakan untuk membuat struktur halaman web adalah...',
          options: ['Python', 'HTML', 'SQL', 'C++'],
          correctIndex: 1,
          explanation: 'HTML (HyperText Markup Language) mendefinisikan struktur halaman web.',
        ),
        Question(
          text: '1 Byte sama dengan berapa bit?',
          options: ['4 bit', '8 bit', '16 bit', '32 bit'],
          correctIndex: 1,
          explanation: '1 byte terdiri dari 8 bit.',
        ),
        Question(
          text: 'Perangkat yang menghubungkan jaringan lokal ke internet adalah...',
          options: ['Monitor', 'Router', 'Printer', 'Scanner'],
          correctIndex: 1,
          explanation: 'Router meneruskan paket data antara jaringan lokal dan internet.',
        ),
        Question(
          text: 'Sistem operasi Android dikembangkan oleh...',
          options: ['Apple', 'Microsoft', 'Google', 'Samsung'],
          correctIndex: 2,
          explanation:
              'Android dikembangkan oleh Google berbasis kernel Linux.',
        ),
        Question(
          text: 'RAM merupakan jenis memori yang bersifat...',
          options: [
            'Permanen',
            'Sementara (volatile)',
            'Hanya bisa dibaca',
            'Eksternal',
          ],
          correctIndex: 1,
          explanation: 'Isi RAM hilang ketika daya listrik dimatikan.',
        ),
        Question(
          text: 'Protokol aman untuk mengakses situs web adalah...',
          options: ['FTP', 'HTTP', 'HTTPS', 'SMTP'],
          correctIndex: 2,
          explanation:
              'HTTPS mengenkripsi komunikasi antara browser dan server.',
        ),
        Question(
          text: 'Istilah untuk perangkat lunak berbahaya adalah...',
          options: ['Firmware', 'Malware', 'Freeware', 'Shareware'],
          correctIndex: 1,
          explanation: 'Malware (malicious software) dirancang untuk merusak sistem atau mencuri data.',
        ),
      ],
    ),
    QuizCategory(
      id: 'flutter',
      title: 'Flutter & Dart',
      description: 'Uji pemahamanmu tentang Flutter',
      icon: Icons.flutter_dash_rounded,
      color: AppColors.error,
      questions: [
        Question(
          text: 'Bahasa pemrograman yang digunakan Flutter adalah...',
          options: ['Kotlin', 'Swift', 'Dart', 'JavaScript'],
          correctIndex: 2,
          explanation:
              'Flutter menggunakan Dart yang dikembangkan oleh Google.',
        ),
        Question(
          text: 'Widget yang memiliki state yang dapat berubah adalah...',
          options: [
            'StatelessWidget',
            'StatefulWidget',
            'InheritedWidget',
            'RenderObject',
          ],
          correctIndex: 1,
          explanation: 'StatefulWidget memiliki objek State yang dapat memanggil setState().',
        ),
        Question(
          text:
              'Method untuk memperbarui tampilan pada StatefulWidget adalah...',
          options: ['build()', 'initState()', 'setState()', 'dispose()'],
          correctIndex: 2,
          explanation: 'setState() memberi tahu framework bahwa state berubah sehingga build() dijalankan ulang.',
        ),
        Question(
          text: 'Widget untuk menyusun anak secara vertikal adalah...',
          options: ['Row', 'Column', 'Stack', 'Wrap'],
          correctIndex: 1,
          explanation: 'Column menyusun children dari atas ke bawah.',
        ),
        Question(
          text: 'File konfigurasi dependensi pada proyek Flutter adalah...',
          options: [
            'package.json',
            'build.gradle',
            'pubspec.yaml',
            'main.dart',
          ],
          correctIndex: 2,
          explanation: 'pubspec.yaml berisi dependensi, aset, dan font proyek.',
        ),
        Question(
          text: 'Class yang digunakan untuk berpindah halaman di Flutter adalah...',
          options: ['Router', 'Navigator', 'PageView', 'Scaffold'],
          correctIndex: 1,
          explanation:
              'Navigator mengelola tumpukan rute melalui push() dan pop().',
        ),
        Question(
          text: 'Fitur yang menerapkan perubahan kode tanpa kehilangan state adalah...',
          options: ['Hot Restart', 'Hot Reload', 'Cold Boot', 'Full Build'],
          correctIndex: 1,
          explanation: 'Hot Reload menyuntikkan kode baru sambil mempertahankan state aplikasi.',
        ),
        Question(
          text: 'Class untuk mendapatkan ukuran layar perangkat adalah...',
          options: ['MediaQuery', 'SizedBox', 'Container', 'Padding'],
          correctIndex: 0,
          explanation:
              'MediaQuery menyediakan informasi ukuran dan orientasi layar.',
        ),
      ],
    ),
  ];

  static QuizCategory byId(String id) =>
      categories.firstWhere((c) => c.id == id);
}
