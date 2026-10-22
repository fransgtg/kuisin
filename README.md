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
| ![Home](<img width="1080" height="2400" alt="home" src="https://github.com/user-attachments/assets/000fe297-696c-46b9-96ca-9088d4588c81" />
) | ![Quiz](<img width="1080" height="2400" alt="kuis" src="https://github.com/user-attachments/assets/47298837-d73a-4b4b-8ba8-205ff1596519" />
) | ![Hasil](<img width="1080" height="2400" alt="hasil" src="https://github.com/user-attachments/assets/ba127f22-86cb-4b58-a84d-30cfd27a1860" />
) |

| Review | Riwayat | Papan Skor |
|---|---|---|
| ![Review](<img width="1080" height="2400" alt="pembahasan" src="https://github.com/user-attachments/assets/2b3ef41c-0195-4609-8d24-b2cb803f4b2a" />
) | ![Riwayat](<img width="1080" height="2400" alt="riwayat" src="https://github.com/user-attachments/assets/6a3334ed-851e-461f-be24-3050bfe913a4" />
) | ![Papan Skor](<img width="1080" height="2400" alt="skor" src="https://github.com/user-attachments/assets/71a472a7-6d0a-4da4-bcb5-22435d9f28b3" />
) |

| Dark Mode |
|---|
| ![Dark Mode](<img width="1080" height="2400" alt="gelap" src="https://github.com/user-attachments/assets/5674e091-6271-4bc3-8761-b1e8ac40e6dc" />
) |

### Link Mockup / Prototype
[Kuisin Mockup (prototype interaktif)](https://www.figma.com/proto/48zfOIlVC3GRp4sKa3CnCU/Kuisin?node-id=16-280&t=htNlvBMaanKePSiE-1&scaling=min-zoom&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=6%3A201)

### Link Video Presentasi
_[https://drive.google.com/drive/folders/1nr3HOVqD66lPRRfyeAVt-savIZltk7hb?usp=sharing]_
