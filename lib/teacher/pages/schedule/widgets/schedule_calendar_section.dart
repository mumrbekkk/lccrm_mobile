import 'package:flutter/material.dart';

class ScheduleCalendarSection extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime selectedDate;
  final List<Map<String, dynamic>> lessons;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<DateTime> onDateSelected;

  const ScheduleCalendarSection({
    super.key,
    required this.focusedMonth,
    required this.selectedDate,
    required this.lessons,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(
      focusedMonth.year,
      focusedMonth.month,
    );

    final firstDayOfMonth = DateTime(focusedMonth.year, focusedMonth.month, 1);
    final int leadingEmptyCells = firstDayOfMonth.weekday % 7;

    final lessonDates = lessons.map((e) => e['date'].toString()).toSet();

    final List<Widget> cells = [];

    for (int i = 0; i < leadingEmptyCells; i++) {
      cells.add(const SizedBox.shrink());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(focusedMonth.year, focusedMonth.month, day);
      final dateKey = _dateKey(date);

      final isSelected =
          selectedDate.year == date.year &&
              selectedDate.month == date.month &&
              selectedDate.day == date.day;

      final hasLessons = lessonDates.contains(dateKey);

      cells.add(
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => onDateSelected(date),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6D28FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$day',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF374151),
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                hasLessons
                    ? Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF6D28FF),
                    shape: BoxShape.circle,
                  ),
                )
                    : const SizedBox(
                  width: 4,
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD7DBE2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _MonthButton(
                icon: Icons.chevron_left,
                onTap: onPreviousMonth,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '${_monthFullName(focusedMonth.month)} ${focusedMonth.year}',
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              _MonthButton(
                icon: Icons.chevron_right,
                onTap: onNextMonth,
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(child: Center(child: _WeekDayLabel('Su'))),
              Expanded(child: Center(child: _WeekDayLabel('Mo'))),
              Expanded(child: Center(child: _WeekDayLabel('Tu'))),
              Expanded(child: Center(child: _WeekDayLabel('We'))),
              Expanded(child: Center(child: _WeekDayLabel('Th'))),
              Expanded(child: Center(child: _WeekDayLabel('Fr'))),
              Expanded(child: Center(child: _WeekDayLabel('Sa'))),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cells.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 52,
            ),
            itemBuilder: (context, index) {
              return cells[index];
            },
          ),
        ],
      ),
    );
  }

  String _dateKey(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  String _monthFullName(int month) {
    const names = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return names[month];
  }
}

class _WeekDayLabel extends StatelessWidget {
  final String text;

  const _WeekDayLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _MonthButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MonthButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD7DBE2)),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF6B7280),
          size: 20,
        ),
      ),
    );
  }
}