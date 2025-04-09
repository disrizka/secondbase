import 'package:flutter/material.dart';
import 'package:secondbase/services/quran_check_list.dart';
import 'package:secondbase/services/tracker_service.dart';
import 'package:secondbase/utils/constant/app_color.dart';
import 'package:secondbase/utils/constant/app_image';

class QuranTracker extends StatefulWidget {
  const QuranTracker({super.key});

  @override
  State<QuranTracker> createState() => _QuranTrackerState();
}

class _QuranTrackerState extends State<QuranTracker> {
  final TrackerService _trackerService = TrackerService();

  @override
  void initState() {
    super.initState();
    _trackerService
        .setInitialJuz(); // WAJIB: agar semua user punya data awal Juz 1–30
  }

  Future<void> resetAllJuz() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: AppColor.secondaryColor,
            title: Text(
              "Konfirmasi Reset",
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Yakin ingin mereset semua progress membaca Al-Quran?",
              style: TextStyle(color: AppColor.primaryColor.withOpacity(0.8)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(
                  "Batal",
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 161, 11, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: Text("Reset", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await _trackerService.resetAllJuz();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Progress berhasil di-reset")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Quraisyah',
          style: TextStyle(
            fontFamily: "Baloo2",
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: AppColor.secondaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_return, color: AppColor.secondaryColor),
          iconSize: 24.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColor.secondaryColor),
            iconSize: 30.0,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quran Tracker",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Hii kakak sholihaaaa~ ketemu lagi nih sama aku, aku kangen dehh! Udah tilawah belum hari ini?, jangan lupa tilawah yaa biar cantik nna luar dalam ~",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: AppColor.primaryColor.withOpacity(0.8),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(AppImage.notes, width: 100),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(child: QuranCheckList()),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: resetAllJuz,
              icon: Icon(Icons.refresh),
              label: Text("Reset Progress"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 161, 11, 0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
