# ⚔️ Rivals Stats: Marvel Rivals Tracker

**Rivals Stats** adalah aplikasi pelacak statistik (*stat tracker*) untuk game **Marvel Rivals**. Aplikasi ini dirancang untuk memberikan wawasan mendalam tentang performa pemain dan peringkat global. Pengguna dapat melihat **Global Leaderboard**, mencari profil pemain menggunakan Username/UID, dan menganalisis statistik detail seperti *Win Rate*, *Top Heroes*, dan *Match History*.

Proyek ini dibangun sebagai demonstrasi implementasi **Arsitektur Modular** menggunakan **Flutter** dan **GetX**, dengan fokus pada penanganan data API yang kompleks dan tampilan UI yang informatif.

---

## 🚀 Fitur Utama Aplikasi

| Halaman | Fungsionalitas Kunci |
| :--- | :--- |
| **📊 Leaderboard** | **Global Rankings:** Menampilkan daftar pemain teratas (*Leaderboard*) berdasarkan Rank Score musim ini, lengkap dengan *Tier Icon* dan statistik ringkas. |
| **🔍 Player Search** | **Pencarian Pemain:** Fitur pencarian pemain menggunakan Username atau UID yang terintegrasi langsung di halaman Home. |
| **👤 Player Profile** | **Statistik Akun:** Menampilkan *Avatar*, *Rank*, *Level*, dan ringkasan performa (*Win Rate*, *Matches*, *Play Time*) secara visual. |
| **🦸 Top Heroes** | **Analisis Hero:** Daftar horizontal *Hero* yang paling sering dimainkan beserta *Win Rate* spesifik untuk setiap karakter. |
| **⚔️ Match History** | **Riwayat Pertandingan:** Daftar pertandingan terakhir dengan detail *Victory/Defeat*, *K/D/A*, durasi, dan *Hero* yang digunakan. |

---

## ⚙️ Tech Stack & Arsitektur

### Struktur Proyek (Modular GetX)

Proyek ini menggunakan struktur **Feature-Based Modular** untuk memisahkan logika bisnis dari antarmuka pengguna.

| Folder | Tanggung Jawab | Komponen Kunci |
| :--- | :--- | :--- |
| **`lib/config`** | **Konfigurasi Global** | `app_pages.dart`, `app_routes.dart`, `app_theme.dart`, `app_colors.dart`. |
| **`lib/data`** | **Data Layer** | `models/`, `services/`. |
| **`lib/modules`** | **Presentation Layer** | `home/` (Search Players), `leaderboard/` (Player Rankings), `profile/` (Detail Stats & History). |

### Komponen Teknis Inti

| Komponen | Alat/Konsep | Fokus Utama |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.x+ | Pengembangan aplikasi *high-performance*. |
| **State Management** | GetX | Manajemen *state* reaktif (`Obx`, `Rx`) dan navigasi. |
| **Networking** | Dio | Klien HTTP canggih dengan konfigurasi *Interceptors* dan *BaseOptions*. |
| **Data Source** | Marvel Rivals API | Sumber data *real-time* untuk statistik pemain dan *leaderboard*. |
| **Security** | `flutter_dotenv` | Pengelolaan API Key yang aman. |

---

## 🛠️ Instruksi Menjalankan Aplikasi

### A. Prasyarat & Setup

1.  **Clone Repository:**
    ```bash
    git clone https://github.com/azrieldwim/rivals_stats
    flutter pub get
    ```

2.  **Konfigurasi API Key (Wajib):**
    Aplikasi ini memerlukan akses ke API Marvel Rivals.
    * Buat file **`.env`** di **tingkat akar *root* proyek**.
    * Masukkan API Key Anda:
        ```env
        API_KEY=YOUR_SECRET_KEY_HERE
        ```

3.  **Build Native Assets:**
    (Opsional: Jika Anda mengubah ikon aplikasi)
    ```bash
    flutter pub run flutter_launcher_icons
    ```

### B. Menjalankan Aplikasi

Jalankan perintah berikut untuk memulai aplikasi di emulator atau perangkat fisik:

```bash
# 1. Jalankan aplikasi
flutter run
# Catatan: Gunakan flag no-impeller jika mengalami masalah render grafis pada Emulator Android lama
flutter run --no-enable-impeller
```

## 🖼️ Dokumentasi
![alt text](https://github.com/azrieldwim/rivals_stats/blob/master/assets/images/dokumentasi1.png?raw=true)
![alt text](https://github.com/azrieldwim/rivals_stats/blob/master/assets/images/dokumentasi2.png?raw=true)
