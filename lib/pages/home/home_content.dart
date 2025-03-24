import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secondbase/api/album/fetch.dart';
import 'package:secondbase/pages/home/quran_tracker_content.dart';

import 'package:secondbase/utils/app_color.dart';
import 'package:secondbase/utils/app_image';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Salam dan email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Assalamualaikum',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  Text(
                    userEmail ?? 'User Email',
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ],
              ),
              // Gambar
              Image.asset(AppImage.homeGirl, width: 106, height: 106),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColor.secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Baris atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard(
                      AppImage.quran,
                      'Quran',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FetchAlbum()),
                        );
                      },
                    ),
                    const SizedBox(width: 40),
                    _buildCard(AppImage.audio, 'Audio'),
                  ],
                ),
                const SizedBox(height: 50),
                // Baris bawah
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard(
                      AppImage.notes,
                      'Quran Tracker',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuranTracker(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 40),
                    _buildCard(AppImage.tasbih, 'Dzikir'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String imagePath, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 80, height: 80),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
