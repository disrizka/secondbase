import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:secondbase/pages/login/login.dart';
import 'package:secondbase/utils/app_color.dart';
import 'package:secondbase/utils/app_image';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: AppColor.primaryColor,
      key: introKey,
      pages: [
        PageViewModel(
          titleWidget: SizedBox.shrink(),
          bodyWidget: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 90),
                Image.asset(AppImage.intro1),
                SizedBox(height: 40),
                Text(
                  "Assalamualaikum\nKakak!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Baloo2",
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: AppColor.secondaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Bismillahirrahmanirrahim. Selamat datang di Quraisyah! Yuk, jadi akrab sama Al-Qur’an bareng aplikasi ini. Semoga tiap ayat yang dibaca makin nempel di hati kita yaa!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          titleWidget: SizedBox.shrink(),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 170),
              Text(
                "One Day One Juz,\n One Step Closer to\n Jannah ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Baloo2",
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: AppColor.secondaryColor,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(AppImage.intro2),
              SizedBox(height: 20),
            ],
          ),
        ),
        PageViewModel(
          titleWidget: SizedBox.shrink(),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Image.asset(AppImage.intro3),
              const SizedBox(height: 20),
              Text(
                "Let the Quran be\n your light in the\n darkest nights.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Baloo2",
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: AppColor.secondaryColor,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Jadikan aku sebagai teman\n Tadabbur Quran Kamu!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ],
      showNextButton: false,
      showDoneButton: true,
      done: const Text(
        "Done",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
    );
  }
}
