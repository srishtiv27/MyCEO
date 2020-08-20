import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_ceo/menu_page.dart';
import 'package:my_ceo/upvote_page.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'welcome_screen.dart';
import 'card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DownvotePage extends StatefulWidget {
  static String id = 'downvote-page';
  @override
  _DownvotePageState createState() => _DownvotePageState();
}

class _DownvotePageState extends State<DownvotePage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void DownvotesStream() async {
    await for (var snapshot in _firestore.collection('downvotes').snapshots()) {
      for (var downvote in snapshot.documents) {
        print(downvote.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFf8f8ff),
//      backgroundColor: Color(0xFFeaf0fa),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.09852,
            ),
            child: Center(
              child: Text(
                'Downvotes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.04926,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('downvotes').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
              final downvotes = snapshot.data.documents;
              List<CeoCard> downvoteWidgets = [];
              for (var downvote in downvotes) {
                final ceoName = downvote.data['name'];
                final company = downvote.data['company'];
                final age = downvote.data['age'];
                final image = downvote.data['image'];
                final downvoteWidget = CeoCard(
                  screenHeight: screenHeight,
                  deviceWidth: deviceWidth,
                  ceoName: ceoName,
                  company: company,
                  image: image,
                  age: age,
                );
                downvoteWidgets.add(downvoteWidget);
              }
              return Expanded(
                flex: 6,
                child: ListView(
                  children: downvoteWidgets,
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
                      bottom: screenHeight * 0.03694,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, UpvotePage.id);
                          },
                          child: Icon(
                            Typicons.thumbs_up,
                            size: screenHeight * 0.05295,
                            color: Colors.grey,
                          ),
                        ),
                        Icon(
                          Typicons.thumbs_down,
                          size: screenHeight * 0.05295,
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
