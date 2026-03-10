import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  static const _activeColor = Color(0xFF8A2BE2);
  static const _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? _activeColor : _inactiveColor,
            ),

            const SizedBox(height: 2),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              style: TextStyle(
                fontSize: isActive ? 13 : 12,
                color: isActive ? _activeColor : _inactiveColor,
                fontWeight:
                isActive ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}

