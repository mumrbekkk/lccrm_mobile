import 'package:flutter/material.dart';

import '../requests/schedule.dart';

class StudentSchedulePage extends StatefulWidget {
  const StudentSchedulePage({super.key});

  @override
  State<StudentSchedulePage> createState() => _StudentSchedulePageState();
}

class _StudentSchedulePageState extends State<StudentSchedulePage> {
  DateTime _selectedDate = DateTime.now();
  Map<String, List<dynamic>> _scheduleByDate = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _setScheduleData();
  }

  Future<void> _setScheduleData() async {
    setState(() => _isLoading = true);
    final response = await ScheduleRequestsService().getStudentWeeklySchedule();

    if (!mounted) return;

    if (response is List) {
      final Map<String, List<dynamic>> grouped = {};
      for (var lesson in response) {
        final dateKey = lesson["lesson_date"];
        if (grouped[dateKey] == null) {
          grouped[dateKey] = [];
        }
        grouped[dateKey]!.add(lesson);
      }
      setState(() {
        _scheduleByDate = grouped;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _onRefresh() async {
    await _setScheduleData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCalendarStrip(),
        const SizedBox(height: 16),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: _isLoading 
                ? const Center(child: CircularProgressIndicator())
                : _buildScheduleList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarStrip() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(7, (index) {
            final date = firstDayOfWeek.add(Duration(days: index));
            final isSelected = date.day == _selectedDate.day &&
                date.month == _selectedDate.month &&
                date.year == _selectedDate.year;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                });
              },
              child: Container(
                width: 60,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: isSelected
                      ? null
                      : Border.all(color: const Color(0xFFE2E8F0), width: 1),
                ),
                child: Column(
                  children: [
                    Text(
                      _getDayName(date.weekday),
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF1E293B),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }

  String _formatDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String _calculateDuration(String start, String end) {
    try {
      final startParts = start.split(':').map(int.parse).toList();
      final endParts = end.split(':').map(int.parse).toList();

      final startTime = Duration(hours: startParts[0], minutes: startParts[1]);
      final endTime = Duration(hours: endParts[0], minutes: endParts[1]);

      final diff = endTime - startTime;
      return '${diff.inHours}h ${diff.inMinutes.remainder(60)}m';
    } catch (e) {
      return "-";
    }
  }

  String _parseRoom(dynamic room) {
    if (room == null) return "-";
    if (room is Map<String, dynamic>) {
      return room["name"]?.toString() ?? room["number"]?.toString() ?? "-";
    }
    return room.toString();
  }

  Widget _buildScheduleList() {
    final dateKey = _formatDateKey(_selectedDate);
    final lessons = _scheduleByDate[dateKey] ?? [];

    if (lessons.isEmpty) {
      return ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          const Center(
            child: Text(
              "No lessons for this day",
              style: TextStyle(color: Color(0xFF94A3B8)),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        final group = lesson["group"] ?? {};
        final teachers = (lesson["teachers"] as List?)?.join(", ") ?? "-";

        return _buildScheduleItem(
          startTime: lesson["start_time"] ?? "-",
          endTime: lesson["end_time"] ?? "-",
          groupName: group["name"] ?? "No Group",
          subject: lesson["topic"] ?? group["course_name"] ?? "-",
          room: _parseRoom(lesson["room"]),
          teacher: teachers,
          duration: _calculateDuration(
            lesson["start_time"] ?? "00:00",
            lesson["end_time"] ?? "00:00",
          ),
          color: Colors.indigo,
        );
      },
    );
  }

  Widget _buildScheduleItem({
    required String startTime,
    required String endTime,
    required String groupName,
    required String subject,
    required String room,
    required String teacher,
    required String duration,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  startTime,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  endTime,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(color: color, width: 4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subject,
                    style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 14
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          teacher,
                          style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text(
                        room,
                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
