import 'package:flutter/material.dart';
import 'package:secondbase/utils/app_color.dart';
import 'package:secondbase/utils/app_image';

class QuranTracker extends StatefulWidget {
  const QuranTracker({super.key});

  @override
  State<QuranTracker> createState() => _QuranTrackerState();
}

class _QuranTrackerState extends State<QuranTracker> {
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
            fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
        child: Container(
          width: double.infinity,
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Quran Tracker",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
              Image.asset(AppImage.notes, width: 100),
            ],
            
          ),
        ),
      ),
      
    );
  }
}
