import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';





final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
Future<String> getUserPhoneNumber() async {
    final user = _auth.currentUser;
    if (user == null) {
      return Future.value("");
    } else {
      Map<String, dynamic> user_deets =
          (await _fireStore.collection('users').doc(user.uid).get()).data()!;
      return user_deets["caregiver_ph_number"];
    }
  }