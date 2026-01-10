import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_aapp/parent/main.dart';
import 'package:test_flutter_aapp/student/main.dart';
import 'package:test_flutter_aapp/teacher/main.dart';

import 'login_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();

    final access = prefs.getString("access");
    final role = prefs.getString("role");

    await Future.delayed(const Duration(milliseconds: 400));

    if (access != null && role != null) {
      _navigateByRole(role);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  void _navigateByRole(String role) {
    Widget page;

    switch (role) {
      case "student":
        page = const StudentMainPage();
        break;
      case "parent":
        page = const ParentHomePage();
        break;
      case "teacher":
        page = const TeacherHomePage();
        break;
      default:
        page = const LoginPage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
