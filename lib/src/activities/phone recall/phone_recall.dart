import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
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
  late String target_number;
  @override
  initState() {
    _textEditingController = TextEditingController();
    super.initState();
    getUserPhoneNumber().then((value) {
      setState(() {
        //get the random string

        target_number = value;
      });
    });
  }

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

  _onEvaluateAnswer() {
    setState(() {
      correctAns = _textEditingController.text == target_number;
      print(correctAns);
    });
  }

  final confettiController = ConfettiController();

  // @override
  // void dispose() {
  //   confettiController.dispose();
  //   super.dispose();
  // }
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
      body: Container(
        constraints: const BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
            minHeight: double.infinity,
            minWidth: double.infinity),
        decoration: BoxDecoration(
          color: Color(0xfffffde8),
          image: DecorationImage(
            image: AssetImage("assets/images/patient_main_menu_bg.jpg"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        //height: 1000.0,
        padding: const EdgeInsets.symmetric(vertical: 100.0),

        child: Column(
          children: [
            ConfettiWidget(
              confettiController: confettiController,
              shouldLoop: true,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _textEditingController,
              ),
            ),
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
            Text(result,
             style: Theme.of(context).textTheme.headline5!),
            const SizedBox(
              height: 45,
            )
          ],
        ),
      ),
    );
  }
}