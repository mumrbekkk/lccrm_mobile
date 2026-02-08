import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/student/components/page_payout.dart';
import 'package:test_flutter_aapp/student/pages/courses.dart';
import 'package:test_flutter_aapp/student/pages/ratings.dart';
import 'package:test_flutter_aapp/student/pages/schedule.dart';
import 'package:test_flutter_aapp/student/requests/header.dart';
import 'pages/home.dart';

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({super.key});

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  int _currentIndex = 0;
  int _coinCount = 0;
  int _notificationCount = 0;

  late final List<Widget> _pages = [
    StudentHomePage(refreshHeader: _loadHeaderData),
    const StudentSchedulePage(),
    const StudentCoursesPage(),
    const StudentRatingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadHeaderData();
  }

  Future<void> _loadHeaderData() async {
    try {
      final coins = await getCoinCount();
      final notifications = await getNotificationCount();
      if (!mounted) return;
      setState(() {
        _coinCount = coins;
        _notificationCount = notifications;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return StudentPageLayout(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      // On tab changed
      currentIndex: _currentIndex,
      onTabChanged: (index) {
        if (_currentIndex == index) return;
        setState(() {
          _currentIndex = index;
        });
      },
      // Counts for header
      notificationCount: _notificationCount,
      coinCount: _coinCount,
    );
  }
}

