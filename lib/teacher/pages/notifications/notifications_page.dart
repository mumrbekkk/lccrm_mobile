import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_aapp/teacher/pages/notifications/widgets/appbar.dart';
import 'package:test_flutter_aapp/teacher/pages/notifications/widgets/notification_card.dart';

import '../../../common/requests/auth_requests.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<dynamic> _notifications = [];
  int _unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    _setNotifications();
  }

  Future<void> _setNotifications() async {
    final response = await AuthRequests.getNotifications();
    final unreadCountResponse = await AuthRequests.getUnreadNotificationsCount();

    if (!mounted) return;

    setState(() {
      _notifications = response["results"];
      _unreadNotificationsCount = unreadCountResponse["count"];
    });
  }

  Future<void> _markAllNotificationsAsRead() async {
    await AuthRequests.markAllNotificationsAsRead();

    if (!mounted) return;

    await _setNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationsAppBar(
        unreadCount: _unreadNotificationsCount,
        markAllNotificationsAsRead: _markAllNotificationsAsRead,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final n = _notifications[index];

          return NotificationCard(
            title: n["notification"]["title"],
            description: n["notification"]["message"],
            time: DateFormat('d MMMM y, H:mm').format(DateTime.parse(n["notification"]["created_at"])),
            icon: Icons.assignment_outlined,
            iconColor: Color(0xFF3B82F6),
            iconBgColor: Color(0xFFEFF6FF),
            statusColor: Color(0xFF3B82F6),
            isUnread: !n["is_read"],
          );
        },
      ),
    );
  }
}
