import 'package:flutter/material.dart';

import 'package:test_flutter_aapp/teacher/components/layout.dart';
import 'package:test_flutter_aapp/teacher/pages/groups/groups.dart';
import 'package:test_flutter_aapp/teacher/pages/home/home.dart';
import 'package:test_flutter_aapp/teacher/pages/profile/profile_page.dart';
import 'package:test_flutter_aapp/teacher/pages/schedule/schedule.dart';

import '../common/requests/auth_requests.dart';

class TeacherMainPage extends StatefulWidget {
  const TeacherMainPage({super.key});

  @override
  State<TeacherMainPage> createState() => _TeacherMainPageState();
}

class _TeacherMainPageState extends State<TeacherMainPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;
  int _notificationsCount = 0;

  @override
  void initState() {
    super.initState();

    _pages = [
      const Home(),
      const Groups(),
      const Schedule(),
      const ProfilePage(),
    ];

    _setNotificationsCount();
  }

  Future<void> _setNotificationsCount() async {
    final unreadCountResponse = await AuthRequests.getUnreadNotificationsCount();

    if (!mounted) return;

    setState(() {
      _notificationsCount = unreadCountResponse["count"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TeacherPageLayout(
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
      notificationCount: _notificationsCount,
    );
  }
}

