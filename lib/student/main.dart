import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/student/components/page_payout.dart';
import 'package:test_flutter_aapp/student/pages/courses.dart';
import 'package:test_flutter_aapp/student/pages/qr.dart';
import 'package:test_flutter_aapp/student/pages/ratings.dart';
import 'package:test_flutter_aapp/student/pages/schedule.dart';
import 'pages/home.dart';

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({super.key});

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    StudentHomePage(),
    StudentSchedulePage(),
    StudentQRPage(),
    StudentCoursesPage(),
    StudentRatingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return StudentPageLayout(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      currentIndex: _currentIndex,
      onTabChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

