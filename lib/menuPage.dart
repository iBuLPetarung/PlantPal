import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final String category;
  const MenuPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4E5),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF0D4715)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Plant...',
                    hintStyle: TextStyle(color: Color(0xFF0D4715)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF0D4715)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
      child: Text(
        "Daftar tanaman untuk kategori: $category",
        style: TextStyle(fontSize: 18),
      ),
    ),
      floatingActionButton: Transform.translate(
        offset: Offset(0, -27),
        child: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            onPressed: () {
              print("Flower icon clicked");
            },
            backgroundColor: Color(0xFF99BC85),
            shape: CircleBorder(),
            child: Icon(
              Icons.local_florist,
              size: 32,
              color: Color(0xFFEAF4E5),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
