import 'package:flutter/material.dart';

class ProfileTopSection extends StatelessWidget {
  final String? picture;
  final String? firstName;
  final String? lastName;

  const ProfileTopSection({
    super.key,
    this.picture,
    this.firstName,
    this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
          "$firstName $lastName",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
