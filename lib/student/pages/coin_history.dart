import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../requests/coins.dart';

class StudentCoinHistoryPage extends StatefulWidget {
  const StudentCoinHistoryPage({super.key});

  @override
  State<StudentCoinHistoryPage> createState() => _StudentCoinHistoryPageState();
}

class _StudentCoinHistoryPageState extends State<StudentCoinHistoryPage> {
  List<Map<String, dynamic>> _coinHistoryItems = [];
  String _totalBalance = "0";

  @override
  void initState() {
    super.initState();

    _setCoinHistory();
  }

  Future<void> _setCoinHistory() async {
    final coinRequestService = CoinsRequestsService();

    final results = await coinRequestService.getStudentCoinHistory();
    final total = await coinRequestService.getStudentTotalCoinCount();
    if (results is! List) return;

    if (!mounted) return;

    setState(() {
      _coinHistoryItems = results
          .whereType<Map<String, dynamic>>()
          .toList();
      _totalBalance = total.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF475569)),
        title: const Text(
          "Coin Balansi",
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF9C3),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFFDE68A), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDE68A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.monetization_on,
                      color: Color(0xFFB45309),
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Umumiy Balans",
                    style: TextStyle(
                      color: Color(0xFF92400E),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _totalBalance,
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Weekly/Monthly Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard("This Week", "+580"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard("This Month", "+2,450"),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Oxirgi Coinlar",
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Earnings List
            ..._coinHistoryItems.map((e) {
              return _buildEarningItem(
                icon: Icons.check_circle_outline,
                title: e["category"]["category_name"],
                time: DateFormat('d MMMM y, H:mm').format(DateTime.parse(e["created_at"])),
                amount: (e["category"]["coin_count"] + (e["extra_coins"] ?? 0)).toString(),
                iconColor: Colors.green,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningItem({
    required IconData icon,
    required String title,
    required String time,
    required String amount,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF9C3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.monetization_on,
                  color: Color(0xFFB45309),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  amount,
                  style: const TextStyle(
                    color: Color(0xFFB45309),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
