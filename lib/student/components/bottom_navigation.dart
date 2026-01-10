import 'package:flutter/material.dart';


class StudentBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const StudentBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF8A2BE2),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Asosiy",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: "Jadval",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: "QR",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: "Kurslar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          label: "Reytinglar",
        ),
      ],
    );
  }


}
