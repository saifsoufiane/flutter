import 'package:appointement/widget/splash/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  User _user;

  HomeScreen(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user.email),
        elevation: 0.0,
        backgroundColor: Color(0xff053F5E),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text(' Log out')));
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MySplash()),
                    (Route<dynamic> route) => false);
              });
            },
          ),
        ],
      ),
    );
  }
}
