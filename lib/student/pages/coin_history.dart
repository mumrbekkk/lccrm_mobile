import 'package:flutter/material.dart';


class StudentCoinHistoryPage extends StatelessWidget {
  const StudentCoinHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CoinHistory"),
      ),
      body: const Center(
        child: Text(
          "CoinHistory Page",
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}