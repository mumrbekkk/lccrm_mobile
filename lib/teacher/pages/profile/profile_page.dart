import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/teacher/pages/profile/widgets/profile_detail_section.dart';
import 'package:test_flutter_aapp/teacher/pages/profile/widgets/top_section.dart';

import '../../../common/requests/auth_requests.dart';
import '../../../common/services/auth_service.dart';
import '../../../common/services/auth_service2.dart';
import '../../../login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? picture;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // {
  // "id": 0,
  // "username": "dzWBleM-sYVA3HRfVf-evzZJsEeVLqV7TFD6b9Fv9SiWeGEz@",
  // "email": "user@example.com",
  // "first_name": "string",
  // "last_name": "string",
  // "picture": "string",
  // "phone": "540454388137712",
  // "role": "manager"
  // }
  Future<void> _loadProfile() async {
    final data = await AuthRequests.getProfileDetails();

    setState(() {
      username = data["username"];
      email = data["email"];
      firstName = data["first_name"];
      lastName = data["last_name"];
      phone = data["phone"];
      picture = data["picture"];
    });
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await AuthService2.logout();
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileTopSection(
                firstName: firstName,
                lastName: lastName,
                picture: picture
            ),

            const SizedBox(height: 24),

            ProfileDetailsSection(
              username: username,
              email: email,
              phone: phone,
            ),

            const SizedBox(height: 40),

            _LogoutButton(onPressed: _handleLogout),
          ],
        ),
      ),
    );
  }
}


class _LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _LogoutButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text(
          "Logout",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}


