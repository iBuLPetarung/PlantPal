import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(color: Color(0xFF0D4715)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(child: Text("This is the Notification Page!")),
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
