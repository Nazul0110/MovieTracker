# MovieTracker 📽️

## 📌 Nama Aplikasi
**MovieTracker – Aplikasi Manajemen Koleksi Film**

---

## 📝 Deskripsi Singkat
MovieTracker adalah aplikasi Flutter sederhana yang digunakan untuk **mencatat dan mengelola koleksi film pribadi**.  
Pengguna dapat menandai film yang sudah ditonton, memberi tanda favorit, melihat statistik koleksi, serta mengatur tema aplikasi (terang/gelap).

Aplikasi ini dirancang sebagai **projek latihan Flutter dengan 5 layar** dan tampilan yang modern.

---

## ✨ Fitur Utama

1. **Halaman Home**
   - Menampilkan ringkasan koleksi:
     - Total film
     - Jumlah yang sudah ditonton
     - Jumlah yang belum ditonton
     - Jumlah film favorit
   - Section *“Favorit Teratas”* berisi daftar film yang ditandai sebagai favorit.
   - AppBar dengan sapaan: **“Halo, Suheti 👋”** dan foto profil.

2. **Halaman Movies**
   - Menampilkan seluruh daftar film.
   - **Search bar** untuk mencari film berdasarkan judul.
   - **Filter genre** menggunakan dropdown (Semua, Sci-Fi, Action, Romance, dll).
   - Tombol:
     - Tandai **sudah/belum ditonton**
     - Tambah/hapus dari **favorit**
   - Klik salah satu film → masuk ke halaman detail dengan animasi (Hero + transition).

3. **Halaman Stats (Statistics)**
   - Menampilkan statistik koleksi film:
     - Persentase sudah ditonton
     - Persentase belum ditonton
     - Persentase favorit  
   - Progress bar animasi.
   - Rekomendasi aksi sederhana (contoh: “Coba pilih 1–2 film baru untuk ditonton minggu ini”).

4. **Halaman Favorites**
   - Menampilkan hanya film yang sudah ditandai sebagai **favorit**.
   - Bisa menghapus dari favorit langsung dari list.
   - Bisa masuk ke halaman detail film dari list favorit.

5. **Halaman Settings**
   - Mengganti **tema** aplikasi (Light / Dark mode).
   - Menampilkan informasi singkat tentang aplikasi.

---

## 🛠️ Teknologi yang Digunakan

- **Flutter** (Dart)
- **Material Design 3**
- **StatefulWidget** untuk mengelola state sederhana
- **AnimatedSwitcher, Hero, PageRouteBuilder** untuk animasi transisi

---

## ▶️ Cara Menjalankan Aplikasi

Pastikan kamu sudah menginstall:

- Flutter SDK
- Android Studio / VS Code + Flutter extension
- Emulator Android / device fisik dengan mode developer aktif

### 1. Clone / buka project
Jika sudah punya folder project, langsung buka saja di VS Code / Android Studio.

cd flutter_suheti

2. Install dependency

Jalankan perintah:

flutter pub get

3. Jalankan aplikasi
Pastikan emulator atau HP sudah terdeteksi, lalu:

flutter run

Atau dari VS Code:
Tekan F5 atau
Klik tombol Run > Start Debugging

👤 Identitas
Silakan ganti bagian ini dengan data kamu:

Nama : Suheti

NIM : 14022300033

Kelas : 5B-INF

---
<img width="475" height="1004" alt="Screenshot 2025-12-10 215523" src="https://github.com/user-attachments/assets/644e7786-da37-4d53-b0e8-cdd783bbe845" />
<img width="478" height="1006" alt="Screenshot 2025-12-10 215532" src="https://github.com/user-attachments/assets/c9886651-af4a-464e-aa13-ff0302bdadce" />
<img width="470" height="1008" alt="Screenshot 2025-12-10 215542" src="https://github.com/user-attachments/assets/57abcbf7-8965-4b78-a45e-54a80b33051e" />
<img width="474" height="1002" alt="Screenshot 2025-12-10 215555" src="https://github.com/user-attachments/assets/257b64f8-5ef4-416d-9454-283c67f752b0" />
<img width="481" height="1007" alt="Screenshot 2025-12-10 215609" src="https://github.com/user-attachments/assets/7522d1ed-f76f-454e-8d7e-489d022b52b8" />
