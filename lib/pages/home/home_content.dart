import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:secondbase/pages/dzikir/screens/zikir_screen.dart';
import 'package:secondbase/utils/constant/app_color.dart';
import 'package:secondbase/utils/constant/app_image';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:secondbase/api/album/fetch.dart';
import 'package:secondbase/pages/home/quran_tracker_content.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _currentIndex = 0;

  final List<String> _carouselImages = [
    'assets/carosel/carosel1.jpeg',
    'assets/carosel/carosel2.jpeg',
    'assets/carosel/carosel3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
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
          icon: Icon(Icons.menu, color: AppColor.secondaryColor),
          iconSize: 24.0,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColor.secondaryColor),
            iconSize: 30.0,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: AppColor.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Assalamualaikum',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
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

                  Image.asset(AppImage.homeGirl, width: 106, height: 106),
                ],
              ),
            ),

            const SizedBox(height: 10),

            CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
                viewportFraction: 0.85,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items:
                  _carouselImages.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),

            const SizedBox(height: 10),

            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: _carouselImages.length,
                effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 10,
                  activeDotColor: Color.fromARGB(255, 156, 102, 117),
                  dotColor: AppColor.secondaryColor,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // === Fitur Card Section ===
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
                          AppImage.intro2,
                          'Quran',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FetchAlbum(),
                              ),
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
                        SizedBox(width: 40),
                        Column(
                          children: [
                            _buildCard(
                              AppImage.tasbih,
                              'Zikir',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ZikirScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        // _buildCard(AppImage.tasbih, 'Dzikir'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String imagePath, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
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
                fontSize: 12,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
