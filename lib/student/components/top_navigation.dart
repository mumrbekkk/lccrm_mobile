import 'package:flutter/material.dart';

import '../pages/coin_history.dart';
import '../pages/notifications.dart';
import '../pages/profile.dart';

class StudentTopNavigation extends StatelessWidget
    implements PreferredSizeWidget {
  const StudentTopNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: const Color(0xFF8A2BE2),
          child: const Icon(Icons.school, color: Colors.white),
        ),
      ),
      title: const Text(
        "LC_CRM",
        style: TextStyle(color: Colors.black),
      ),
      actions: const [
        _Coins(),
        SizedBox(width: 8),
        _Notifications(),
        SizedBox(width: 8),
        _Profile(),
        SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ---------------- COMPONENTS ----------------

class _Coins extends StatelessWidget {
  const _Coins();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const StudentCoinHistoryPage(),
          ),
        );
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        backgroundColor: const Color(0xFFFFF3E0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.monetization_on, color: Colors.orange, size: 18),
          SizedBox(width: 4),
          Text(
            "1247",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class _Notifications extends StatelessWidget {
  const _Notifications();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Notifications",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const StudentNotificationsPage(),
          ),
        );
      },
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.notifications_none, size: 26),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                "3",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Profile",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const StudentProfilePage(),
          ),
        );
      },
      icon: CircleAvatar(
        backgroundColor: const Color(0xFF8A2BE2),
        child: const Icon(Icons.person, color: Colors.white),
      ),
    );
  }
}
