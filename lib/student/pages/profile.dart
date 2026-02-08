import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/core/services/auth_service.dart';

import '../../login_page.dart';
import '../requests/profile.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  bool _loading = true;
  bool _isLoggingOut = false;

  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? picture;

  @override
  void initState() {
    super.initState();
    _setProfileData();
  }

  Future<void> _setProfileData() async {
    final data = await ProfileRequestsService().getProfile();
    if (!mounted) {return;}
    setState(() {
      username = data["username"];
      email = data["email"];
      firstName = data["first_name"];
      lastName = data["last_name"];
      phone = data["phone"];
      picture = data["picture"];
      _loading = false;
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
      setState(() {
        _isLoggingOut = true;
      });

      await AuthService.logout();

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
    if (_loading) {
      return Scaffold(
        appBar: AppBar(
            title: const Text("Profile"),
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF1E293B),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.red),
                onPressed: _handleLogout,
              ),
            ],
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF8A2BE2),
              backgroundImage: picture != null ? NetworkImage(picture!) : null,
              child: picture == null
                  ? const Icon(Icons.person, size: 40, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 12),
            Text(
              "${firstName ?? ""} ${lastName ?? ""}".trim().isEmpty
                  ? "Student"
                  : "${firstName ?? ""} ${lastName ?? ""}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            _ProfileDetailsSection(
              username: username,
              email: email,
              phone: phone,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                icon: _isLoggingOut
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.logout, color: Colors.white),
                label: Text(
                  _isLoggingOut ? "Logging out..." : "Logout",
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isLoggingOut ? null : _handleLogout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileDetailsSection extends StatelessWidget {
  final String? username;
  final String? email;
  final String? phone;

  const _ProfileDetailsSection({
    this.username,
    this.email,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _ProfileInfoTile(
            icon: Icons.person_outline,
            label: "Username",
            value: username,
          ),
          const Divider(height: 1),
          _ProfileInfoTile(
            icon: Icons.email_outlined,
            label: "Email",
            value: email,
          ),
          const Divider(height: 1),
          _ProfileInfoTile(
            icon: Icons.phone_outlined,
            label: "Phone",
            value: phone,
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;

  const _ProfileInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF8A2BE2)),
      title: Text(label),
      subtitle: Text(value?.isNotEmpty == true ? value! : "—"),
    );
  }
}
