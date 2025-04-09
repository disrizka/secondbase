import 'package:flutter/material.dart';
import 'package:secondbase/pages/home/home_content.dart';
import 'package:secondbase/pages/home/settings_page.dart';
import 'package:secondbase/utils/constant/app_color.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    Center(
      child: Text(
        'Like',
        style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
      ),
    ),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     'Quraisyah',
      //     style: TextStyle(
      //       fontFamily: "Poppins",
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       color: AppColor.secondaryColor,
      //     ),
      //   ),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: Icon(Icons.menu, color: AppColor.secondaryColor),
      //     iconSize: 24.0,
      //     onPressed: () {},
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.search, color: AppColor.secondaryColor),
      //       iconSize: 30.0,
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: _widgetOptions[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.primaryColor,
        selectedItemColor: AppColor.secondaryColor,
        unselectedItemColor: AppColor.secondaryColor.withOpacity(0.5),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Like',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
