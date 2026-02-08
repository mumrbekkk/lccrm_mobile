import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/student/pages/course_detail.dart';

import '../requests/courses.dart';

class StudentCoursesPage extends StatefulWidget {
  const StudentCoursesPage({super.key});

  @override
  State<StudentCoursesPage> createState() => _StudentCoursesPageState();
}

class _StudentCoursesPageState extends State<StudentCoursesPage> {
  int _totalCourses = 0;
  List<dynamic> _courses = [];

  @override
  void initState() {
    super.initState();
    _setCourses();
  }

  Future<void> _setCourses() async {
    final response = await CoursesRequestsService().getCourses();

    if (!mounted) return;

    setState(() {
      _courses = response["results"];
      _totalCourses = response["count"];
    });
  }

  Future<void> _onRefresh() async {
    await _setCourses();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Mening Kurslarim",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Sizda xozirda ${_totalCourses}ta kurs mavjud",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ..._courses.map((course) {
            return _buildCourseCard(
              title: course["course_name"],
              instructor: course["teachers"].isNotEmpty ? course["teachers"][0] : "Unknown Teacher",
              groupName: course["group_name"],
              progress: course["progress"]["progress_rate"],
              lessons: "${course["progress"]["completed_lesson_count"]}/${course["progress"]["all_lessons"]}",
              icon: Icons.calculate_outlined,
              color: Colors.blue,
              groupId: course["id"],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String instructor,
    required String groupName,
    required int progress,
    required String lessons,
    required IconData icon,
    required Color color,
    required int groupId
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      instructor,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      groupName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CourseDetail(groupId: groupId,)),
                  );
                },
                icon: const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF94A3B8)
                )
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Progress",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                "$progress%",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (progress / 100).clamp(0.0, 1.0),
              backgroundColor: color.withAlpha(30),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.play_circle_outline, size: 16, color: Color(0xFF94A3B8)),
              const SizedBox(width: 4),
              Text(
                "$lessons darslar",
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




