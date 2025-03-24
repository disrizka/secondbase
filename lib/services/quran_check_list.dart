import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // kalau kamu pakai auth

class QuranChecklist extends StatefulWidget {
  const QuranChecklist({Key? key}) : super(key: key);

  @override
  State<QuranChecklist> createState() => _QuranChecklistState();
}

class _QuranChecklistState extends State<QuranChecklist> {
  Map<String, bool> juzChecklist = {};
  final userId =
      FirebaseAuth.instance.currentUser?.uid ??
      'dummyUser'; 

  @override
  void initState() {
    super.initState();
    fetchChecklist();
  }

  Future<void> fetchChecklist() async {
    final doc =
        await FirebaseFirestore.instance
            .collection('users_quran_tracker')
            .doc(userId)
            .get();
    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      setState(() {
        juzChecklist = Map<String, bool>.from(data['juzProgress'] ?? {});
      });
    } else {
      // Jika user baru, generate 30 juz
      final initialChecklist = {for (var i = 1; i <= 30; i++) 'juz$i': false};
      await FirebaseFirestore.instance
          .collection('users_quran_tracker')
          .doc(userId)
          .set({'juzProgress': initialChecklist, 'updatedAt': Timestamp.now()});
      setState(() {
        juzChecklist = initialChecklist;
      });
    }
  }

  void updateJuz(String juzKey, bool value) async {
    setState(() {
      juzChecklist[juzKey] = value;
    });

    await FirebaseFirestore.instance
        .collection('users_quran_tracker')
        .doc(userId)
        .update({'juzProgress.$juzKey': value, 'updatedAt': Timestamp.now()});
  }

  @override
  Widget build(BuildContext context) {
    if (juzChecklist.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView(
      children:
          juzChecklist.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              child: CheckboxListTile(
                title: Text(
                  'Juz ${entry.key.replaceAll('juz', '')}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: entry.value,
                onChanged: (val) {
                  if (val != null) updateJuz(entry.key, val);
                },
                activeColor: Colors.green,
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }).toList(),
    );
  }
}
