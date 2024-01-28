import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_sqflite/screens/add_notes.dart';
import 'package:to_do_sqflite/screens/home.dart';
import 'package:to_do_sqflite/screens/splash_screen.dart';
import 'package:to_do_sqflite/screens/welcome_screen.dart';

SharedPreferences? _preferences;
void main() {
  runApp(
    MaterialApp(
<<<<<<< HEAD
=======
      debugShowCheckedModeBanner: false,
>>>>>>> b8caef9 (.)
      home: WelcomeScreen(),
      routes: {'addnotes': (context) => const AddNotes()},
    ),
  );
}
