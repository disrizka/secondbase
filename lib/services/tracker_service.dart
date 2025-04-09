import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrackerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? 'default_user';

  CollectionReference<Map<String, dynamic>> get _trackerRef =>
      _firestore.collection('users_aka').doc(userId).collection('juzTracker');

  Future<void> setInitialJuz() async {
    final snapshot = await _trackerRef.get();

    if (snapshot.docs.isEmpty) {
      for (int i = 1; i <= 30; i++) {
        await _trackerRef.doc('juz_$i').set({'juz': i, 'isChecked': false});
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getJuzStream() {
    return _trackerRef.orderBy('juz').snapshots();
  }

  Future<void> updateCheckStatus(int juz, bool isChecked) async {
    await _trackerRef.doc('juz_$juz').update({'isChecked': isChecked});
  }

  Future<void> resetAllJuz() async {
    final snapshot = await _trackerRef.get();
    for (var doc in snapshot.docs) {
      await doc.reference.update({'isChecked': false});
    }
  }
}
