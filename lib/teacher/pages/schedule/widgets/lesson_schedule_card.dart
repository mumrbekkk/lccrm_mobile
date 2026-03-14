import 'package:flutter/material.dart';

class LessonScheduleCard extends StatelessWidget {
  final String title;
  final String group;
  final String time;
  final String room;
  final String status;

  const LessonScheduleCard({
    super.key,
    required this.title,
    required this.group,
    required this.time,
    required this.room,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isOngoing = status.toLowerCase() == "ongoing";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD7DBE2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFF6D28FF),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  group,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 14,
                  runSpacing: 8,
                  children: [
                    _MetaItem(
                      icon: Icons.access_time_outlined,
                      text: time,
                    ),
                    _MetaItem(
                      icon: Icons.location_on_outlined,
                      text: room,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isOngoing
                  ? const Color(0xFFECFDF3)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isOngoing
                    ? const Color(0xFF86EFAC)
                    : const Color(0xFFD1D5DB),
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isOngoing
                    ? const Color(0xFF16A34A)
                    : const Color(0xFF6B7280),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF6B7280),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}