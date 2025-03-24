import 'package:flutter/material.dart';
import 'package:secondbase/services/auth_service.dart';
import 'package:secondbase/utils/app_color.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  Color get primaryColor =>
      isDarkMode ? AppColor.primaryColor : AppColor.primaryColor;
  Color get secondaryColor =>
      isDarkMode ? Colors.black : AppColor.secondaryColor;
  Color get cardColor => isDarkMode ? Colors.grey[850]! : AppColor.primaryColor;
  Color get textColor => isDarkMode ? AppColor.primaryColor : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pengaturan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.settings, color: primaryColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Card Bahasa
            _buildSettingsTile(
              icon: Icons.language,
              title: 'Bahasa',
              onTap: () {},
            ),

            const SizedBox(height: 15),

            // Card Tema
            _buildSettingsTile(
              icon: Icons.dark_mode,
              title: 'Tema',
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),

            const Spacer(),

            // Tombol Sign Out
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize: const Size(double.infinity, 60),
                elevation: 3,
              ),
              onPressed: () async {
                await AuthService().signout(context: context);
              },
              child: Text(
                "Sign Out",
                style: TextStyle(
                  color: secondaryColor,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: secondaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ),
            trailing ??
                Icon(Icons.arrow_forward_ios, size: 16, color: primaryColor),
          ],
        ),
      ),
    );
  }
}
