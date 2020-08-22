import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_ceo/downvote_page.dart';
import 'package:my_ceo/login_screen.dart';
import 'package:my_ceo/registration_screen.dart';
import 'upvote_page.dart';
import 'package:my_ceo/welcome_screen.dart';
import 'menu_page.dart';

void main() {
  runApp(MyCEO());
}

class MyCEO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      initialRoute: MenuPage.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MenuPage.id: (context) => MenuPage(),
        UpvotePage.id: (context) => UpvotePage(),
        DownvotePage.id: (context) => DownvotePage(),
      },
    );
  }
}
