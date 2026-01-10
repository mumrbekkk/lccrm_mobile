import 'package:flutter/material.dart';


class StudentNotificationsPage extends StatelessWidget {
  const StudentNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: const Center(
        child: Text(
          "Notifications Page",
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}