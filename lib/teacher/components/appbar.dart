import 'package:flutter/material.dart';

import '../../common/components/btn_notification.dart';
import '../pages/notifications/notifications_page.dart';


class TeacherAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  final int notificationCount;

  const TeacherAppBar({
    super.key,
    required this.notificationCount,
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
        BtnNotification(
          notificationCount: notificationCount,
          page: const TeacherNotificationsPage(),
        ),
        SizedBox(width: 2),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

