import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectroots/src/pages/patient_screen.dart';
import 'package:projectroots/src/pages/signup_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _fireStore = FirebaseFirestore.instance;
  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    
    
    
    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            child: Center(
          heightFactor: 2,
           
          child: Image.asset(
            'assets/images/roots_icon.jpeg',
            height: 250,
          ),
          // height: 25,
          // width: 25,
        )),
        Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
            child: Text("Helping Those Who Helped Us The Most",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 178, 133),
                    fontSize: 20))),

        Container(
            child: Center(
                heightFactor: 1.5,
                child: ButtonTheme(
                    minWidth: 600.0,
                    height: 100.0,
                    child: ElevatedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                      onPressed: () async {
                        final credential = await signInWithGoogle();
                        var docRef = _fireStore.collection("users").doc(credential.user?.uid);

                        docRef.get().then((doc) => {
                      if (doc.exists) {
                            print(doc.data())
    }        else {
        // doc.data() will be undefined in this case
         _fireStore.collection('users').doc(credential.user?.uid).set({})
    },
     print(credential.user?.uid),
                        print(credential.user?.email)
}) ;
},              

                          style: ElevatedButton.styleFrom(
                          minimumSize: Size(250, 60),
                          backgroundColor: Color.fromARGB(255, 10, 10, 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
        )))),
 
      ],
    );
  }
}
