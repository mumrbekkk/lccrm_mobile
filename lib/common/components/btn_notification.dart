

import 'package:flutter/material.dart';

class BtnNotification extends StatelessWidget {
  final int notificationCount;
  final Widget page;

  const BtnNotification({
    super.key,
    required this.notificationCount,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: "Notifications",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications_none, size: 25),
            if (notificationCount > 0) Positioned(
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