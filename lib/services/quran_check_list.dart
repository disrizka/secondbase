import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondbase/utils/constant/app_color.dart';
import 'tracker_service.dart';

class QuranCheckList extends StatefulWidget {
  const QuranCheckList({super.key});

  @override
  State<QuranCheckList> createState() => _QuranCheckListState();
}

class _QuranCheckListState extends State<QuranCheckList> {
  final TrackerService _trackerService = TrackerService();

  // Function to determine progress color
  Color _getProgressColor(double progress) {
    if (progress < 0.3) {
      return const Color.fromARGB(255, 161, 11, 0);
    } else if (progress < 0.6) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  void initState() {
    super.initState();
    _trackerService.setInitialJuz();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _trackerService.getJuzStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(child: Text("No data"));
        }

        final docs = snapshot.data!.docs;
        final totalJuz = docs.length;
        final checkedJuz = docs.where((doc) => doc['isChecked'] == true).length;
        final progress = totalJuz > 0 ? checkedJuz / totalJuz : 0.0;
        final progressColor = _getProgressColor(progress);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quran Reading Progress",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      minHeight: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${(progress * 100).toStringAsFixed(1)}% Completed",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: totalJuz,
                itemBuilder: (context, index) {
                  final juzData = docs[index].data();
                  final int juz = juzData['juz'];
                  final bool isChecked = juzData['isChecked'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          'Juz $juz',
                          style: TextStyle(
                            fontFamily: "Baloo2",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        checkColor: AppColor.secondaryColor,
                        activeColor: Colors.white,
                        value: isChecked,
                        onChanged: (value) {
                          _trackerService.updateCheckStatus(
                            juz,
                            value ?? false,
                          );
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
