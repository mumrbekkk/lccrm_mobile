import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_aapp/student/requests/home.dart';


class StudentHomePage extends StatefulWidget{
  final Future<void> Function() refreshHeader;

  const StudentHomePage({
    super.key,
    required this.refreshHeader,
  });

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage>
    with WidgetsBindingObserver {
  String? fullName;
  /// Attendance Related States
  int _presentAttendance = 0;
  int _absentAttendance = 0;
  int _attendanceRate = 0;

  @override
  void initState() {
    super.initState();
    _loadUserFullName();
    _setAttendanceStatistics();
  }

  Future<void> _loadUserFullName() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() { fullName = prefs.getString("full_name"); });
  }

  Future<void> _setAttendanceStatistics() async {
    final response = await HomeRequestsService().getAttendanceStatistics();
    if (!mounted) {return;}
    setState(() {
      _presentAttendance = response["present_attendance_count"];
      _absentAttendance = response["absent_attendance_count"];
      _attendanceRate = (response["rate_attendance_count"] as num).round();
    });
  }

  /// ------------------------ ON REFRESH ------------------------ //
  Future<void> _onRefresh() async {
    await widget.refreshHeader();
    await _setAttendanceStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 40,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          _WelcomeSection(fullName: fullName,),
          SizedBox(height: 20),
          _AttendanceCard(
            presentAttendance: _presentAttendance,
            absentAttendance: _absentAttendance,
            attendanceRate: _attendanceRate,
          ),
        ],
      )
    );
  }
}


class _WelcomeSection extends StatelessWidget {
  final String? fullName;

  const _WelcomeSection({super.key, this.fullName,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Xush kelibsiz!",
          style: TextStyle(color: Colors.black54),
        ),
        SizedBox(height: 4),
        Text(
          fullName ?? "",
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
  final int presentAttendance;
  final int absentAttendance;
  final int attendanceRate;


  const _AttendanceCard({
    required this.presentAttendance,
    required this.absentAttendance,
    required this.attendanceRate,    
  });

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
            children: [
              _StatItem(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                value: presentAttendance.toString(),
                label: "Kelgan",
                bgColor: Color(0xFFE8F5E9),
              ),
              _StatItem(
                icon: Icons.cancel,
                iconColor: Colors.red,
                value: absentAttendance.toString(),
                label: "Kelmagan",
                bgColor: Color(0xFFFFEBEE),
              ),
              _StatItem(
                icon: Icons.trending_up,
                iconColor: Color(0xFF8A2BE2),
                value: "$attendanceRate%",
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




