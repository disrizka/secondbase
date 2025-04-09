import 'package:flutter/material.dart';
import 'package:secondbase/pages/get_screen.dart';
import 'package:secondbase/pages/login/login.dart';
import 'package:secondbase/services/pref_handler.dart';
import 'package:secondbase/utils/constant/app_color.dart';
import 'package:secondbase/utils/constant/app_image';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  void getDataUser() async {
    // get data user
    var userId = await PreferenceHandler.getId();
    var lookWelcoming = await PreferenceHandler.getLookWelcoming();
    Future.delayed(Duration(seconds: 2), () {
      if (lookWelcoming == false) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Getscreen()),
        );
      } else if (userId != '') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Getscreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            Image.asset(
              AppImage.logo,
              height: MediaQuery.of(context).size.width * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            SizedBox(height: 20), 
            Text(
              'Quraisyah',
              style: TextStyle(
                fontFamily: "Baloo2",
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
