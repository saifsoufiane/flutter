import 'package:appointement/widget/home/home.dart';
import 'package:appointement/widget/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  runApp(MySplash());
}

class MySplash extends StatelessWidget {
  User result = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meet Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (result != null ? HomeScreen(result) : LoginScreen()),
    );
  }
}
