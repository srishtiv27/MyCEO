import 'package:flutter/material.dart';
import 'package:my_ceo/login_screen.dart';
import 'package:my_ceo/registration_screen.dart';
import 'rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFeaf0fa),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.09852,
          ),
          Container(
            height: screenHeight * 0.4,
            child: Image.asset(
              'images/welcome-image.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03694,
          ),
          Text(
            'Welcome to MyCEO',
            style: TextStyle(
              fontSize: screenHeight * 0.03694,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02463,
          ),
          Text(
            'Vote for all your favourite CEOs!',
            style: TextStyle(
              fontSize: screenHeight * 0.01970,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.06157,
          ),
          RoundedButton(
            buttonTitle: 'Log In',
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          RoundedButton(
            buttonTitle: 'Sign Up',
            color: Colors.white,
            textColor: Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
