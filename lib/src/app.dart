import 'package:flutter/material.dart';
import 'package:projectroots/src/pages.dart';
import 'package:projectroots/src/activities.dart';
import 'package:projectroots/theme.dart';
import 'dart:math';
import 'package:projectroots/src/pages/signup_form.dart';
import 'package:projectroots/src/activities/wordsearch/word_search.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Roots',
      theme: projectRootsThemeData,
      routes: {
        HomePage.path: (context) => const HomePage(),
        PhoneRecallActivity.path: (context) => const PhoneRecallActivity(),
        PictureQuizActivity.path: (context) => PictureQuizActivity(),
        TodoActivity.path: (context) => TodoActivity(),
        ReverseSpellActivity.path: (context) => ReverseSpellActivity(),
        WordSearchActivity.path: (context) => const WordSearchActivity(),
        QueryFormPage.path: (context) => QueryFormPage(),
        PatientScreen.path: ((context) => PatientScreen()),
      },
    );
  }
}
