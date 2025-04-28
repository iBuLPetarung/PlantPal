import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlantListPage extends StatelessWidget {
  const PlantListPage({super.key});

  void _deletePlant(BuildContext context, String id) async {
    try {
      await FirebaseFirestore.instance.collection('plants').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanaman berhasil dihapus!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menghapus tanaman: $e')));
    }
  }

  void _editPlant(BuildContext context, String id, Map<String, dynamic> plant) {
    // Navigasi ke halaman edit (nanti kita buat EditPlantPage)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPlantPage(plantId: id, initialData: plant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tanaman'),
        backgroundColor: const Color(0xFF0D4715),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('plants').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada tanaman ditambahkan.'));
          }

          final plants = snapshot.data!.docs;

          return ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index].data() as Map<String, dynamic>;
              final id = plants[index].id; // ambil ID dokumen

              return ListTile(
                title: Text(plant['name']),
                subtitle: Text('Kategori: ${plant['category']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editPlant(context, id, plant),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePlant(context, id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EditPlantPage extends StatefulWidget {
  final String plantId;
  final Map<String, dynamic> initialData;

  const EditPlantPage({
    super.key,
    required this.plantId,
    required this.initialData,
  });

  @override
  State<EditPlantPage> createState() => _EditPlantPageState();
}
class _EditPlantPageState extends State<EditPlantPage> {
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {};
    widget.initialData.forEach((key, value) {
      _controllers[key] = TextEditingController(text: value.toString());
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _updatePlant() async {
    try {
      Map<String, dynamic> updatedData = {};
      _controllers.forEach((key, controller) {
        updatedData[key] = controller.text.trim();
      });

      await FirebaseFirestore.instance
          .collection('plants')
          .doc(widget.plantId)
          .update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanaman berhasil diperbarui!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui tanaman: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Tanaman'),
        backgroundColor: const Color(0xFF0D4715),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ..._controllers.entries.map(
              (entry) => TextField(
                controller: entry.value,
                decoration: InputDecoration(labelText: entry.key),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePlant,
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
