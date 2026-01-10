import 'package:flutter/material.dart';


class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _WelcomeSection(),
          SizedBox(height: 20),
          _AttendanceCard(),
        ],
      ),
    );
  }
}


class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Xush kelibsiz!",
          style: TextStyle(color: Colors.black54),
        ),
        SizedBox(height: 4),
        Text(
          "Umrbek Madatov",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


class _AttendanceCard extends StatelessWidget {
  const _AttendanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Davomatlar Statistikasi",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.calendar_today, color: Color(0xFF8A2BE2)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _StatItem(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                value: "4",
                label: "Kelgan",
                bgColor: Color(0xFFE8F5E9),
              ),
              _StatItem(
                icon: Icons.cancel,
                iconColor: Colors.red,
                value: "1",
                label: "Kelmagan",
                bgColor: Color(0xFFFFEBEE),
              ),
              _StatItem(
                icon: Icons.trending_up,
                iconColor: Color(0xFF8A2BE2),
                value: "80%",
                label: "Umumiy",
                bgColor: Color(0xFFEDE7F6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// Stat item for AttendanceCard
class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final Color bgColor;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}




