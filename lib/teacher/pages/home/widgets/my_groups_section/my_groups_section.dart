import 'package:flutter/material.dart';

import 'my_group_card.dart';

class MyGroupsSection extends StatelessWidget {
  const MyGroupsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = const [
      {
        "badge": "A",
        "title": "Advanced A1",
        "subject": "English",
        "studentsCount": 12,
      },
      {
        "badge": "B",
        "title": "Beginner B2",
        "subject": "English",
        "studentsCount": 8,
      },
      {
        "badge": "I",
        "title": "Intermediate C1",
        "subject": "Math",
        "studentsCount": 15,
      },
      {
        "badge": "K",
        "title": "Kids Basic",
        "subject": "English",
        "studentsCount": 10,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cardWidth = width < 350 ? width : (width - 12) / 2;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Groups",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: groups.map((group) {
                return SizedBox(
                  width: cardWidth,
                  child: MyGroupCard(
                    badge: group["badge"] as String,
                    title: group["title"] as String,
                    subject: group["subject"] as String,
                    studentsCount: group["studentsCount"] as int,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}