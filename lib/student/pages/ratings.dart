import 'package:flutter/material.dart';

import '../requests/ratings.dart';

class StudentRatingsPage extends StatefulWidget {
  const StudentRatingsPage({super.key});

  @override
  State<StudentRatingsPage> createState() => _StudentRatingsPageState();
}

class _StudentRatingsPageState extends State<StudentRatingsPage> {
  double _overallRating = 0.0;
  List<dynamic> _groupRatings = [];

  @override
  void initState() {
    super.initState();
    _setOverallRating();
    _setGroupRatings();
  }

  Future<void> _setOverallRating() async {
    final data = await RatingsRequestsService().getRatings();

    if (!mounted) return;

    setState(() {
      _overallRating = data["rating"];
    });
  }

  Future<void> _setGroupRatings() async {
    final data = await RatingsRequestsService().getGroupRatings();

    if (!mounted) return;

    setState(() {
      _groupRatings = data;
    });
  }

  Future<void> _onRefresh() async {
    await _setOverallRating();
    await _setGroupRatings();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Summary Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withAlpha(40),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Umumiy Reyting",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _overallRating.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      if (index + 1 <= _overallRating) {
                        // full star
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 24,
                        );
                      } else if (index + 0.5 <= _overallRating) {
                        // half star
                        return const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                          size: 24,
                        );
                      } else {
                        // empty star
                        return const Icon(
                          Icons.star_border,
                          color: Colors.amber,
                          size: 24,
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Guruh Reytinglar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            ..._groupRatings.map((groupRating) {
              return _buildRatingItem(
                  courseName: groupRating["course_name"],
                  score: groupRating["rating"].toString(),
                  groupName: groupRating["group_name"],
                  rank: "1",
                  color: Colors.blue
              );
            }),
          ],
        ),
    );
  }

  Widget _buildRatingItem({
    required String courseName,
    required String score,
    required String groupName,
    required String rank,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  groupName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                score,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 14),
                  SizedBox(width: 2),
                  Text(
                    "Reyting",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
