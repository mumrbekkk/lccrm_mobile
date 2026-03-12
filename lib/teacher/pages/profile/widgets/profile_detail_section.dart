import 'package:flutter/material.dart';

class ProfileDetailsSection extends StatelessWidget {
  final String? username;
  final String? email;
  final String? phone;

  const ProfileDetailsSection({
    super.key,
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

