import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PhoneRecallActivity extends StatefulWidget {
  static const path = '/phone-recall';
  static const name = 'Phone Recall';
  const PhoneRecallActivity({
    super.key,
  });

  @override
  State<PhoneRecallActivity> createState() => _PhoneRecallActivityState();
}

class _PhoneRecallActivityState extends State<PhoneRecallActivity> {
  late final TextEditingController _textEditingController;
  bool? correctAns;
  FlutterTts flutterTts = FlutterTts();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }
  Future<String> getUserPhoneNumber() async {
    final user = _auth.currentUser;
    if (user == null) {
      return Future.value("");
    } else {
      Map<String, dynamic> user_deets =
          (await _fireStore.collection('users').doc(user.uid).get()).data()!;
      return await user_deets["first_name"];
    }
  }

  _onEvaluateAnswer() {
    setState(() {
      correctAns = _textEditingController.text == getUserPhoneNumber();
    });
  }

   

  @override
  Widget build(BuildContext context) {
    String result = "";
    if (correctAns != null && correctAns!) {
      result = "Correct!";
      flutterTts.speak("You got it right!");
    } else if (correctAns != null && !correctAns!) {
      result = "Try again";
      flutterTts.speak("Lets give it another try");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Recall"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter your phone number", // Heading Text Style
              style: Theme.of(context).textTheme.headline4!,
            ),
            const SizedBox(
              height: 45,
            ),
            TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 45,
            ),
            Align(
              child: ElevatedButton(
                  onPressed: _onEvaluateAnswer,
                  child: const Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 53, 227, 218),
                      fontSize: 25,
                    ),
                  )),
            ),
            Text(result),
             
            const SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
