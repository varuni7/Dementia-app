import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

Future<String> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      return Future.value("");
    } else {
      Map<String, dynamic> user_deets =
          (await _fireStore.collection('users').doc(user.uid).get()).data()!;
      print(_fireStore.collection('users').doc(user.uid).get());
      final _random = new Random();
      var list = [
        user_deets["first_name"],
        user_deets["house_colour"],
        user_deets["spouse_name"],
        user_deets["allergy"]
      ];
      return list[_random.nextInt(list.length)];
    }
  }