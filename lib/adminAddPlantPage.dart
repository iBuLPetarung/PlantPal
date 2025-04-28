import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'adminPlantListPage.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _environmentController = TextEditingController();
  final TextEditingController _reproductionController = TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();
  final TextEditingController _careController = TextEditingController();
  final TextEditingController _factsController = TextEditingController();

  void _savePlant() async {
    final name = _nameController.text.trim();
    final category = _categoryController.text.trim();
    final duration = _durationController.text.trim();
    final description = _descriptionController.text.trim();
    final environment = _environmentController.text.trim();
    final reproduction = _reproductionController.text.trim();
    final benefits = _benefitsController.text.trim();
    final care = _careController.text.trim();
    final facts = _factsController.text.trim();

    if (name.isEmpty ||
        category.isEmpty ||
        duration.isEmpty ||
        description.isEmpty ||
        environment.isEmpty ||
        reproduction.isEmpty ||
        benefits.isEmpty ||
        care.isEmpty ||
        facts.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Semua field harus diisi'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('plants').add({
        'name': name,
        'category': category,
        'duration': duration,
        'description': description,
        'environment': environment,
        'reproduction': reproduction,
        'benefits': benefits,
        'care': care,
        'facts': facts,
      });

      // Clear form setelah data disimpan
      _nameController.clear();
      _categoryController.clear();
      _durationController.clear();
      _descriptionController.clear();
      _environmentController.clear();
      _reproductionController.clear();
      _benefitsController.clear();
      _careController.clear();
      _factsController.clear();

      // Tampilkan notifikasi sukses
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tanaman berhasil disimpan!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      // Tunggu sebentar, lalu kembali ke halaman sebelumnya
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menyimpan tanaman'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'Tambah Tanaman',
          style: TextStyle(
            color: Color(0xFF0D4715),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFEAF4E5),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Form Tambah Tanaman',
              style: TextStyle(
                color: Color(0xFF0D4715),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Tanaman',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Kategori (contoh: vegetables)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Durasi Tumbuh (hari)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi Tanaman',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _environmentController,
              decoration: InputDecoration(
                labelText: 'Kebutuhan Lingkungan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reproductionController,
              decoration: InputDecoration(
                labelText: 'Proses Perkembangbiakan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _benefitsController,
              decoration: InputDecoration(
                labelText: 'Manfaat Tanaman',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _careController,
              decoration: InputDecoration(
                labelText: 'Cara Perawatan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _factsController,
              decoration: InputDecoration(
                labelText: 'Fakta Menarik Dari Tumbuhan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _savePlant,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEAF4E5),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Simpan Tanaman',
                style: TextStyle(
                  color: Color(0xFF0D4715),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlantListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[500],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Lihat Daftar Tanaman',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
