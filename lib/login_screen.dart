import 'package:flutter/material.dart';
import 'package:my_ceo/menu_page.dart';
import 'rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      setState(() {
        showSpinner = true;
      });
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        Navigator.pushNamed(context, MenuPage.id);
        setState(() {
          _isLoggedIn = true;
          showSpinner = false;
        });
      } else {
        setState(() {
          showSpinner = false;
        });
      }
    } catch (err) {
      setState(() {
        showSpinner = false;
      });
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFeaf0fa),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.10467,
                  ),
                  Positioned(
                    top: screenHeight * 0.06157,
                    left: screenWidth * 0.05333,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: screenHeight * 0.33866,
                child: Image.asset(
                  'images/login-image.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight * 0.55418,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.04926),
                      topRight: Radius.circular(screenHeight * 0.04926),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.02463,
                          left: screenWidth * 0.08,
                          bottom: screenHeight * 0.03694),
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.03078,
                          color: Color(0xFF112B4C),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06666),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02463,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06666),
                      child: TextField(
                        obscureText: true,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04926,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                      child: RoundedButton(
                        buttonTitle: 'Log In',
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              Navigator.pushNamed(context, MenuPage.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            print(e);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01231,
                    ),
                    Center(
                      child: Text(
                        'or sign in with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01231,
                    ),
                    GestureDetector(
                      onTap: () {
                        _login();
                      },
                      child: Image.asset(
                        'images/google.png',
                        height: screenHeight * 0.03694,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
