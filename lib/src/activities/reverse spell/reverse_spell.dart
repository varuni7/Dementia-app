import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:projectroots/src/extensions/string.dart';
import 'dart:async';
import 'dart:math';
import 'reverse_spell_data.dart';
//part 'reverse_spell_test.dart';

class ReverseSpellActivity extends StatefulWidget {
  static const path = '/reverse_spelling';
  static const name = 'Reverse Spell';

  @override
  State<ReverseSpellActivity> createState() => _ReverseSpellActivityState();
}

class _ReverseSpellActivityState extends State<ReverseSpellActivity> {
  //String target_Word=get_target_word();
  bool isStarted = false;
  bool? correctAns;
  Color? correctTextColor = Colors.green;
  
  late String target_word;

  FlutterTts flutterTts = FlutterTts();
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
    getCurrentUser().then((value) {
      setState(() {
        var rand = new Random();

        //get the random string

        target_word = value;
      });
    });
  }

  void _onStart() {
    setState(() {
      isStarted = true;
    });
  }

  void _speakWord() {
    flutterTts.setLanguage("en-IN");
    flutterTts.setPitch(1);
    flutterTts.speak("Reverse spell the word");
    flutterTts.speak(target_word);
    _onStart();
  }

  void _repeat() {
    flutterTts.speak(target_word);
  }

  void _onEvaluateAnswer() {
    print(target_word.reverse());
    setState(() {
      correctAns = _textEditingController.text.toLowerCase() ==
          target_word.reverse().toLowerCase();

      if (!correctAns!) {
        correctTextColor = Colors.red;
      } else {
        correctTextColor = Colors.green;
      }
    });
  }

  Widget _buildActiviyWidget(BuildContext context) {
    final confettiController = ConfettiController();

    // @override
    // void dispose() {
    //   confettiController.dispose();
    //   super.dispose();
    // }

    @override
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
        backgroundColor: Color.fromRGBO(106, 153, 78, 1),
        title: const Text('Reverse Spell'),
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
        height: 1000.0,
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          //crossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
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
            const SizedBox(
              height: 45,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  correctAns = _textEditingController.text.toLowerCase() ==
                      target_word.reverse().toLowerCase();
                  if (!correctAns!) {
                    correctTextColor = Colors.red;
                  } else {
                    correctTextColor = Colors.green;
                  }
                });

                if (correctAns!) {
                  confettiController.play();
                  Timer(const Duration(seconds: 2), () {
                    confettiController.stop();
                  });
                }
              },
              child: const Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 246, 244, 246),
                  fontSize: 25,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 40),
                  backgroundColor: Color.fromARGB(255, 10, 10, 10),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
            ),
            SizedBox(height: 40),
            OutlinedButton(
              onPressed: _repeat,
              child: Text(
                "Repeat word",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(60, 40),
                  backgroundColor: Color.fromARGB(255, 247, 243, 243),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
            ),
            const SizedBox(
              height: 45,
            ),
            Text(result,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: correctTextColor,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // start game button
    // onclick pick one name and send to tts
    // target word spoken out loud by the app(text to speech)
    //input text box the user can type the answer
    //o/p for success
    // repeat word button to repeat word
    // success/failure
    if (isStarted) {
      return Material(child: _buildActiviyWidget(context));
    }

    return Scaffold(
        backgroundColor: Colors.white10,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 152, 87, 1),
          title: Text('Reverse Spell'),
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
          //padding: const EdgeInsets.symmetric(vertical: 100.0),
          child: Center(
            child: OutlinedButton(
              onPressed: _speakWord,
              child: const Text(
                'Start Game',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.black,
                //padding: EdgeInsets.symmetric(horizontal: 50, vertical: )),
              ),
            ),
          ),
        ));
  }
}
