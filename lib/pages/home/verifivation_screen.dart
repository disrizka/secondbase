import 'package:flutter/material.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // @override
  // void initState() {
  //   super.initState();
    
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Agar konten berada di tengah
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Supaya tidak memenuhi layar
            children: [
              Text(
                "Verifikasi Email",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {},
                child: Text("Resend Email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
