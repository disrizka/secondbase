import 'package:flutter/material.dart';
import 'package:secondbase/pages/introduction_screen.dart';
import 'package:secondbase/utils/app_color.dart';
import 'package:secondbase/utils/app_image';

class Getscreen extends StatefulWidget {
  const Getscreen({super.key});

  @override
  State<Getscreen> createState() => _GetscreenState();
}

class _GetscreenState extends State<Getscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quraisyah",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Baloo2",
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: AppColor.secondaryColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 250,
              child: Text(
                "Memorize and recite Quran easily",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 96, 106, 134),
                ),
              ),
            ),
            SizedBox(height: 50),
            Image.asset(
              AppImage.getStarted,
              height: MediaQuery.of(context).size.width * 1.0,
              width: MediaQuery.of(context).size.width * 1.0,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => IntroScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.tertiaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                elevation: 5,
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
