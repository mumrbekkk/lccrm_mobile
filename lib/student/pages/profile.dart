import 'package:flutter/material.dart';


class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: const Center(
        child: Text(
          "Profile Page",
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}