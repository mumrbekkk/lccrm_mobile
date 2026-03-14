import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/teacher/pages/groups/widgets/group_card.dart';
import 'package:test_flutter_aapp/teacher/pages/groups/widgets/groups_search_field.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allGroups = const [
    {
      "title": "Advanced A1",
      "subject": "English",
      "studentsCount": 12,
    },
    {
      "title": "Beginner B2",
      "subject": "English",
      "studentsCount": 8,
    },
    {
      "title": "Intermediate C1",
      "subject": "Math",
      "studentsCount": 15,
    },
    {
      "title": "Kids Basic",
      "subject": "English",
      "studentsCount": 10,
    },
    {
      "title": "Elementary E1",
      "subject": "English",
      "studentsCount": 14,
    },
    {
      "title": "Starter A0",
      "subject": "English",
      "studentsCount": 9,
    },
  ];

  String _query = '';

  List<Map<String, dynamic>> get _filteredGroups {
    if (_query.trim().isEmpty) return _allGroups;

    final query = _query.toLowerCase();

    return _allGroups.where((group) {
      final title = group["title"].toString().toLowerCase();
      final subject = group["subject"].toString().toLowerCase();

      return title.contains(query) || subject.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groups = _filteredGroups;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "My Groups",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${groups.length} groups assigned",
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 20),
        GroupsSearchField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _query = value;
            });
          },
        ),
        const SizedBox(height: 20),
        ...groups.map(
              (group) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: GroupCard(
              title: group["title"] as String,
              subject: group["subject"] as String,
              studentsCount: group["studentsCount"] as int,
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}