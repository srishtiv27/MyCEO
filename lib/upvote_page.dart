import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_ceo/downvote_page.dart';
import 'package:my_ceo/menu_page.dart';
import 'package:my_ceo/welcome_screen.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UpvotePage extends StatefulWidget {
  static String id = 'upvote-page';
  @override
  _UpvotePageState createState() => _UpvotePageState();
}

class _UpvotePageState extends State<UpvotePage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  bool _isLoggedIn = true;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  void UpvotesStream() async {
    await for (var snapshot in _firestore.collection('upvotes').snapshots()) {
      for (var upvote in snapshot.documents) {
        print(upvote.data);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    UpvotesStream();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFf8f8ff),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Center(
              child: Text(
                'Upvotes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.04926,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('upvotes').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
              final upvotes = snapshot.data.documents;
              List<CeoCard> upVoteWidgets = [];
              for (var upvote in upvotes) {
                final ceoName = upvote.data['name'];
                final company = upvote.data['company'];
                final age = upvote.data['age'];
                final image = upvote.data['image'];
                final upvoteWidget = CeoCard(
                  screenHeight: screenHeight,
                  deviceWidth: deviceWidth,
                  ceoName: ceoName,
                  company: company,
                  image: image,
                  age: age,
                );
                upVoteWidgets.add(upvoteWidget);
              }
              return Expanded(
                flex: 6,
                child: ListView(
                  children: upVoteWidgets,
                ),
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: screenHeight * 0.11083,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: deviceWidth * 0.08,
                        right: deviceWidth * 0.08,
                        bottom: screenHeight * 0.03694),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _logout();
                            _auth.signOut();
                            Navigator.pushNamed(context, WelcomeScreen.id);
                          },
                          child: Icon(
                            Icons.exit_to_app,
                            size: screenHeight * 0.04679,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MenuPage.id);
                          },
                          child: Icon(
                            LineIcons.home,
                            size: screenHeight * 0.04926,
                            color: Colors.grey,
                          ),
                        ),
                        Icon(
                          Typicons.thumbs_up,
                          size: screenHeight * 0.05295,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, DownvotePage.id);
                          },
                          child: Icon(
                            Typicons.thumbs_down,
                            size: screenHeight * 0.05295,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
