import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/teacher/pages/schedule/widgets/lesson_schedule_card.dart';
import 'package:test_flutter_aapp/teacher/pages/schedule/widgets/schedule_calendar_section.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedMonth = DateTime(2026, 3);
  DateTime _selectedDate = DateTime(2026, 3, 14);

  final List<Map<String, dynamic>> _allLessons = const [
    {
      "title": "Present Perfect Tense",
      "group": "Advanced A1",
      "time": "09:00",
      "room": "Room 201",
      "status": "Ongoing",
      "date": "2026-03-14",
    },
    {
      "title": "Past Simple Practice",
      "group": "Beginner B2",
      "time": "11:00",
      "room": "Room 105",
      "status": "Planned",
      "date": "2026-03-14",
    },
    {
      "title": "Speaking Session",
      "group": "Intermediate C1",
      "time": "14:00",
      "room": "Room 303",
      "status": "Planned",
      "date": "2026-03-16",
    },
  ];

  List<Map<String, dynamic>> get _selectedDayLessons {
    final selectedKey = _dateKey(_selectedDate);

    return _allLessons.where((lesson) {
      return lesson["date"] == selectedKey;
    }).toList();
  }

  String _dateKey(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return "$y-$m-$d";
  }

  void _changeMonth(int offset) {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _selectedDayLessons;

    return Container(
      color: const Color(0xFFF6F2FB),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Schedule",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Calendar view",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 22),
          ScheduleCalendarSection(
            focusedMonth: _focusedMonth,
            selectedDate: _selectedDate,
            lessons: _allLessons,
            onPreviousMonth: () => _changeMonth(-1),
            onNextMonth: () => _changeMonth(1),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          const SizedBox(height: 22),
          Text(
            "Lessons for ${_monthName(_selectedDate.month)} ${_selectedDate.day}, ${_selectedDate.year}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 14),
          if (lessons.isEmpty)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFD7DBE2),
                ),
              ),
              child: const Text(
                "No lessons for this day",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 15,
                ),
              ),
            )
          else
            ...lessons.map(
                  (lesson) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LessonScheduleCard(
                  title: lesson["title"] as String,
                  group: lesson["group"] as String,
                  time: lesson["time"] as String,
                  room: lesson["room"] as String,
                  status: lesson["status"] as String,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[month];
  }
}