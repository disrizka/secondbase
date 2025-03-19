import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secondbase/services/auth_service.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE6F0), // Soft pink background
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Greeting
                Text(
                  'Hello👋',
                  style: TextStyle(
                    color: Color(0xFFD63384), // Pink text
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),

                // Email Display
                Text(
                  FirebaseAuth.instance.currentUser!.email!.toString(),
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                const SizedBox(height: 30),
                _logout(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signout(context: context);
      },
      child: const Text(
        "Sign Out",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
