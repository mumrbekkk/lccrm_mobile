import 'package:flutter/material.dart';

import 'bottom_navigation.dart';
import 'top_navigation.dart';

class StudentPageLayout extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  const StudentPageLayout({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FB),

      // ================= APP BAR =================
      appBar: const StudentTopNavigation(),
      // ================= BODY =================
      body: body,
      // ================= BOTTOM NAV =================
      bottomNavigationBar: StudentBottomNavigation(
        currentIndex: currentIndex,
        onTap: onTabChanged,
      ),
    );
  }

}