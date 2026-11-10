import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Icon(Icons.eco, size: 80, color: Colors.green)),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'CabaiScan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                'Versi 1.0.0',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Tentang Aplikasi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              'Halo! Aplikasi ini dibuat untuk membantu kamu, para petani cabai, '
              'mengenali penyakit pada daun dan buah cabai dengan cepat dan mudah. '
              'Cukup foto daun atau buah cabai kamu, dan aplikasi akan langsung '
              'memberitahu kondisinya — sehat atau ada tanda penyakit — lengkap '
              'dengan saran penanganannya. Hasilnya juga bisa didengarkan langsung, '
              'jadi tetap praktis dipakai walau tangan kamu sedang kotor atau sibuk di kebun.',
            ),
            const SizedBox(height: 20),

            const Text(
              'Tujuan aplikasi ini sederhana: Membantu petani cabai mendeteksi '
              'penyakit sedini mungkin, supaya penanganannya bisa lebih cepat dan '
              'hasil panen tetap terjaga. Aplikasi ini juga dibuat sebagai bagian '
              'dari tugas akhir (skripsi) penulis.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              'Aplikasi ini dikembangkan sebagai bagian dari penelitian skripsi, '
              'dengan tujuan membantu petani cabai melakukan deteksi dini '
              'penyakit secara mandiri dan praktis.',
            ),
            const SizedBox(height: 20),

            const Text(
              'Dikembangkan oleh',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text('Istiqomah'),
            const Text(
              'Program Studi: Teknik Informatika, Universitas Cendekia Abditama (UCA)',
            ),
            const SizedBox(height: 20),

            const Text(
              'Teknologi yang digunakan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text('• Flutter (aplikasi mobile)'),
            const Text('• TensorFlow Lite (model CNN)'),
            const Text('• flutter_tts (Text-to-Speech Bahasa Indonesia)'),
          ],
        ),
      ),
    );
  }
}
