import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/teacher/pages/home/widgets/my_groups_section/my_groups_section.dart';
import 'package:test_flutter_aapp/teacher/pages/home/widgets/todays_schedule_section/todays_schedule_section.dart';
import 'package:test_flutter_aapp/teacher/pages/home/widgets/user_info_section.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        UserInfoSection(
          greeting: "Good morning,",
          fullName: "Sarah Johnson",
          subtitle: "You have 4 lessons today",
        ),
        SizedBox(height: 20),
        TodaysScheduleSection(),
        SizedBox(height: 20),
        MyGroupsSection(),
      ],
    );
  }
}
