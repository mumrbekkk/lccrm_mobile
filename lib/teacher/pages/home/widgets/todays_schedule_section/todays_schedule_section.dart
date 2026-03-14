import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/teacher/pages/home/widgets/todays_schedule_section/todays_schedule_tile.dart';


class TodaysScheduleSection extends StatelessWidget {
  const TodaysScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        SizedBox(height: 14),
        TodaysScheduleTile(
          title: "Advanced A1",
          time: "09:00",
          room: "Room 201",
          studentsCount: 12,
          isOngoing: true,
        ),
        SizedBox(height: 12),
        TodaysScheduleTile(
          title: "Beginner B2",
          time: "11:00",
          room: "Room 105",
          studentsCount: 8,
        ),
        SizedBox(height: 12),
        TodaysScheduleTile(
          title: "Intermediate C1",
          time: "14:00",
          room: "Room 303",
          studentsCount: 15,
        ),
        SizedBox(height: 12),
        TodaysScheduleTile(
          title: "Kids Basic",
          time: "16:00",
          room: "Room 101",
          studentsCount: 10,
        ),
      ],
    );
  }
}