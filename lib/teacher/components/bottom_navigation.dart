import 'package:flutter/material.dart';

import '../../common/components/nav_item.dart';

class TeacherBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const TeacherBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      elevation: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Expanded(child: NavItem(
              icon: Icons.home,
              label: "Asosiy",
              index: 0,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
            ),

            Expanded(child: NavItem(
                icon: Icons.people,
                label: "Guruhlar",
                index: 1,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ),

            const SizedBox(width: 56),

            Expanded(child: NavItem(
                icon: Icons.calendar_month,
                label: "Jadval",
                index: 2,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ),

            Expanded(child: NavItem(
              icon: Icons.person,
              label: "Profil",
              index: 3,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
            ),
          ],
        ),
      ),
    );
  }
}