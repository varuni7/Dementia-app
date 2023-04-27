import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'reminders.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
addUserTodoData(tododata) async {
  final user = _auth.currentUser;
  if (user == null) {
    return Future.value("");
  } else {
    try {
      await _fireStore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection("todo")
          .add({
        'created': Timestamp.now(),
        'todo_item': tododata,
        //'registered':
      });
    } catch (e) {
      print(e);
    }
  }
}
