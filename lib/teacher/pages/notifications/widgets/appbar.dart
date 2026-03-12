import 'package:flutter/material.dart';


class NotificationsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int unreadCount;
  final Future<void> Function() markAllNotificationsAsRead;

  const NotificationsAppBar({
    super.key,
    required this.unreadCount,
    required this.markAllNotificationsAsRead,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(color: Color(0xFF4B5563)),
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bildirishnomalar",
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "$unreadCount o'qilmagan",
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextButton(
            onPressed: unreadCount == 0
                ? null
                : () async {
              await markAllNotificationsAsRead();
            },
            style: TextButton.styleFrom(
              backgroundColor: unreadCount == 0 ? const Color(0xFFE5E7EB):
              const Color(0xFFC7C70B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: const Icon(
              Icons.done_all,
              color: Color(0xFF6366F1),
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
