# Kuisin

Aplikasi kuis pilihan ganda berbasis Flutter.

---

## a. Identitas Mahasiswa

| | |
|---|---|
| **Nama** | Frans Malindo Ginting |
| **NIM** | 241401049 |
| **Lab** | Lab 1 PM |

---

## b. Informasi Aplikasi

### Nama Aplikasi
**Kuisin**

### Deskripsi Singkat
Kuisin adalah aplikasi kuis pilihan ganda yang dibuat dengan Flutter. Pengguna memasukkan nama, memilih kategori, lalu menjawab soal yang urutan soal dan pilihan jawabannya diacak setiap kali bermain. Setelah kuis selesai, aplikasi menampilkan skor, durasi pengerjaan, dan pembahasan setiap soal. Hasil setiap permainan tercatat di riwayat dan papan skor.

### Fitur yang Tersedia
- **Input nama pemain** sebelum memulai kuis.
- **4 kategori kuis**: Pengetahuan Umum, Sains, Teknologi, serta Flutter & Dart (8 soal per kategori).
- **Pengacakan soal dan pilihan jawaban** setiap kali kuis dimulai.
- **Umpan balik langsung**: jawaban dikunci setelah dipilih dan langsung ditandai benar/salah, disertai penjelasan.
- **Navigasi soal**: tombol sebelumnya/berikutnya dan navigator nomor soal untuk lompat ke soal tertentu.
- **Progress bar** yang menunjukkan jumlah soal yang sudah dijawab.
- **Halaman hasil** berisi skor dalam bentuk ring, jumlah jawaban benar, dan durasi pengerjaan.
- **Review jawaban** untuk melihat kembali setiap soal, jawaban pengguna, kunci jawaban, dan pembahasannya.
- **Riwayat & Papan Skor**: daftar hasil kuis sebelumnya dan peringkat berdasarkan skor tertinggi dan waktu tercepat.
- **Mode terang/gelap** (light/dark theme).
- **Tampilan responsif** untuk HP, tablet, web, dan desktop.
- **Animasi** transisi dan efek tekan pada tombol.

### Teknologi
- Flutter & Dart
- [provider](https://pub.dev/packages/provider) untuk state management
- [flutter_svg](https://pub.dev/packages/flutter_svg) untuk menampilkan ilustrasi SVG
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) untuk membuat ikon aplikasi

### Cara Menjalankan
```bash
flutter pub get
flutter run
```

---

## c. Dokumentasi

### Credit Sumber Aset
| Aset | Sumber |
|---|---|
| Font **Poppins** | [Google Fonts – Poppins](https://fonts.google.com/specimen/Poppins) (SIL Open Font License) |
| Ikon UI | [Material Icons](https://fonts.google.com/icons) (bawaan Flutter) |
| Ilustrasi SVG (`hero.svg`, `logo.svg`, `trophy.svg`, `encourage.svg`) | _[Sumber ilustrasi / dibuat sendiri]_ |
| Ikon aplikasi (`assets/icon/`) | _[Sumber ikon / dibuat sendiri]_ |
| Soal kuis | _[Sumber soal / disusun sendiri]_ |

### Screenshot Tiap Halaman

| Home | Quiz | Hasil |
|---|---|---|
| ![Home](docs/screenshots/home.png) | ![Quiz](docs/screenshots/quiz.png) | ![Hasil](docs/screenshots/result.png) |

| Review | Riwayat | Papan Skor |
|---|---|---|
| ![Review](docs/screenshots/review.png) | ![Riwayat](docs/screenshots/history.png) | ![Papan Skor](docs/screenshots/leaderboard.png) |

| Dark Mode |
|---|
| ![Dark Mode](docs/screenshots/dark_mode.png) |

### Link Mockup / Prototype
[Kuisin Mockup (prototype interaktif)](https://claude.ai/artifact/3Kv5RrqxyqU9pU52DCCDkF)

### Link Video Presentasi
_[Link Google Drive]_