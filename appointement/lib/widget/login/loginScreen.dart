import 'package:appointement/widget/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in to TGD and continue',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your email and password below to continue to the The Growing Developer and let the learning begin!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildTextField(
                    emailController, Icons.account_circle, 'Username'),
                SizedBox(height: 20),
                _buildTextField(passwordController, Icons.lock, 'Password'),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    firebaseAuth
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((res) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(' logged')));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(res.user)),
                      );
                    }).catchError((err) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(err.message),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    });
                  },
                  color: logoGreen,
                  child: Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () {
                    firebaseAuth
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((res) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Success"),
                              content: Text("create user "),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
                      // );
                    }).catchError((err) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(err.message),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    });
                  },
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google),
                      SizedBox(width: 10),
                      Text('Sign-in using Google',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.bottomCenter,
                //  child: _buildFooterLogo(),
                )
              ],
            ),
          ),
        ));
  }

  /// App footer  logo
  /// **/
  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/tgd_white.png',
          height: 40,
        ),
        Text('The Growing Developer',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// *Build text field component
  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    if (labelText == 'Username')
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: secondaryColor, border: Border.all(color: Colors.blue)),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white),
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              // prefix: Icon(icon),
              border: InputBorder.none),
        ),
      );
    else
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: secondaryColor, border: Border.all(color: Colors.blue)),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(color: Colors.white),
          obscureText: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white),
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              // prefix: Icon(icon),
              border: InputBorder.none),
        ),
      );
  }

  void registerToFb() {}
}
