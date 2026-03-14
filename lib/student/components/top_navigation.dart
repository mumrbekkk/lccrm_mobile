import 'package:flutter/material.dart';

import '../../common/components/btn_notification.dart';
import '../pages/coin_history.dart';
import '../pages/notifications.dart';
import '../pages/profile.dart';

class StudentTopNavigation extends StatelessWidget
    implements PreferredSizeWidget {

  final int notificationCount;
  final int coinCount;

  const StudentTopNavigation({
    super.key,
    required this.notificationCount,
    required this.coinCount
  });

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
      titleSpacing: 0,
      title: SizedBox(
        width: 100, // 👈 fixed width (adjust as needed)
        child: const Text(
          "LC CRM",
          maxLines: 2,              // 👈 allow wrapping
          softWrap: true,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      actions: [
        _Coins(coinCount: coinCount,),
        SizedBox(width: 2),
        BtnNotification(
          notificationCount: notificationCount,
          page: const StudentNotificationsPage(),
        ),
        SizedBox(width: 2),
        _Profile(),
        SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ---------------- Actions COMPONENTS ----------------

class _Coins extends StatelessWidget {
  final int coinCount;

  const _Coins({required this.coinCount});

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
        backgroundColor: const Color(0xFFFFE5BC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.monetization_on, color: Colors.orange, size: 18),
          SizedBox(width: 4),
          Text(
            coinCount.toString(),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class _Notifications extends StatelessWidget {
  final int notificationCount;

  const _Notifications({required this.notificationCount});

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
          const Icon(Icons.notifications_none, size: 25),
          Positioned(
            right: 0,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                notificationCount.toString(),
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
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF8A2BE2),
          borderRadius: BorderRadius.circular(12), // 👈 control radius here
        ),
        child: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    );
  }
}
