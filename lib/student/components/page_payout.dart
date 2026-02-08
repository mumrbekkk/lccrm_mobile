import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'bottom_navigation.dart';
import 'top_navigation.dart';

class StudentPageLayout extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final int notificationCount;
  final int coinCount;

  const StudentPageLayout({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onTabChanged,
    required this.notificationCount,
    required this.coinCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2FB),

      // ================= APP BAR =================
      appBar: StudentTopNavigation(
          notificationCount: notificationCount,
          coinCount: coinCount,
      ),

      // ================= BODY =================
      body: body,

      // ================= QR BUTTON & MODAL =================
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8A2BE2),
        onPressed: () {
          _dialogBuilder(context);
        },
        child: const Icon(Icons.qr_code, color: Colors.white),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: StudentBottomNavigation(
        currentIndex: currentIndex,
        onTap: onTabChanged,
      ),
    );
  }
}


Future<void> _dialogBuilder(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final qrToken = prefs.getString("qr_token");
  final String token = qrToken ?? "";

  if (!context.mounted) return;

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
      title: Row(
        children: [
          const Expanded(
            child: Text(
              'Sizning QR kodingiz',
              style: TextStyle(fontSize: 14),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            splashRadius: 20,
            onPressed: () => Navigator.of(context).pop(),
            style: IconButton.styleFrom(backgroundColor: Color(0xFFF7F2FB)),
          ),
        ],
      ),
      content: SizedBox(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(
              data: token,
              size: 200,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    ),
  );
}



