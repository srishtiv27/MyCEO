import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_ceo/ceo.dart';
import 'package:my_ceo/downvote_page.dart';
import 'package:my_ceo/upvote_page.dart';
import 'package:my_ceo/welcome_screen.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'details_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MenuPage extends StatefulWidget {
  static String id = 'menu_page';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Route _createRoute(Ceo ceo) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailsPage(
        ceo: ceo,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  String isFinishedName(int index) {
    if (index > ceoImages.length - 1) {
      return '';
    } else {
      return ceoInfo[index].name;
    }
  }

  String isFinishedCompany(int index) {
    if (index > ceoImages.length - 1) {
      return '';
    } else {
      return ceoInfo[index].company;
    }
  }

  int _index = 0;
  int index2 = 0;
  List<String> ceoImages = [
    'images/julie-sweet.jpg',
    'images/elon-musk1.png',
    'images/mary-barra.png',
    'images/satyanadella1.png',
  ];
//  List<String> ceoNames = ['Elon Musk', 'Mary Barra', 'Satya Nadella'];

  bool _visibleUpvote = false;
  bool _visibleDownvote = false;
  bool _visibleicons = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    CardController controller;
    return Scaffold(
      backgroundColor: Color(0xFFf8f8ff),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.05333,
              right: screenWidth * 0.05333,
              bottom: screenHeight * 0.02463,
              top: screenHeight * 0.06773,
            ),
            child: Center(
              child: Text(
                'Let\'s Vote',
                style: TextStyle(
                  fontSize: screenHeight * 0.04926,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.69,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _visibleicons = !_visibleicons;
                    });
                  },
                  child: TinderSwapCard(
                      orientation: AmassOrientation.BOTTOM,
                      stackNum: 3,
                      maxWidth: MediaQuery.of(context).size.width * 0.98,
                      maxHeight: MediaQuery.of(context).size.width * 1.4,
                      minWidth: MediaQuery.of(context).size.width * 0.88,
                      minHeight: MediaQuery.of(context).size.width * 1.39,
                      swipeEdge: 4.0,
                      cardBuilder: (context, index) {
                        _index = index;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight * 0.0197),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight * 0.0197),
                            ),
                            child: Hero(
                              tag: 'Ceo $index',
                              child: Image.asset(
                                ceoImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        if (align.x < 0) {
                          //Card is LEFT swiping
                          setState(() {
                            _visibleDownvote = !_visibleDownvote;
                          });
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                          setState(() {
                            _visibleUpvote = !_visibleUpvote;
                          });
                        }
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) {
                        // Get orientation & index of swiped card
                        if (orientation == CardSwipeOrientation.RIGHT) {
                          _firestore
                              .collection('upvotes')
                              .document(ceoInfo[index2].id)
                              .setData({
                            'name': ceoInfo[index2].name,
                            'company': ceoInfo[index2].company,
                            'age': ceoInfo[index2].age,
                            'image': ceoImages[index2],
                          });
                        }
                        if (orientation == CardSwipeOrientation.LEFT) {
                          _firestore
                              .collection('downvotes')
                              .document(ceoInfo[index2].id)
                              .setData({
                            'name': ceoInfo[index2].name,
                            'company': ceoInfo[index2].company,
                            'age': ceoInfo[index2].age,
                            'image': ceoImages[index2],
                          });
                        }
                        setState(() {
                          _visibleUpvote = false;
                          _visibleDownvote = false;
                          _visibleicons = false;

                          index2++;
                          if (index2 + 1 > ceoInfo.length) {
                            Alert(
                              context: context,
                              title: 'Finished!',
                              desc: 'You\'ve run out of cards!',
                            ).show();
                          }
                        });
                      },
                      cardController: controller = CardController(),
                      totalNum: ceoImages.length),
                ),
                Positioned(
                  bottom: screenHeight * 0.09605,
                  left: screenWidth * 0.10666,
                  child: Text(
                    isFinishedName(index2),
//                    ceoInfo[index2].name,
                    style: TextStyle(
                      color: Color(0xE6FFFFFF),
                      fontSize: screenHeight * 0.0431,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.06773,
                  left: screenWidth * 0.10666,
                  child: Text(
                    isFinishedCompany(index2),
                    style: TextStyle(
                      color: Color(0xE6FFFFFF),
                      fontSize: screenHeight * 0.02463,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.04926,
                  left: screenWidth * 0.36,
                  child: AnimatedOpacity(
                    opacity: _visibleicons ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 3),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          _createRoute(ceoInfo[_index]),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'SHOW DETAILS',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.01231,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.01333,
                          ),
                          Icon(
                            FontAwesomeIcons.chevronUp,
                            color: Colors.white70,
                            size: screenHeight * 0.01231,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: _visibleUpvote ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Icon(
                      Typicons.thumbs_up,
                      size: screenHeight * 0.12315,
                      color: Colors.white70,
                    ),
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: _visibleDownvote ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      Typicons.thumbs_down,
                      size: screenHeight * 0.12315,
                      color: Colors.white70,
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.03078,
                  left: screenWidth * 0.10666,
                  right: screenWidth * 0.10666,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _firestore
                                  .collection('downvotes')
                                  .document(ceoInfo[index2].id)
                                  .setData({
                                'name': ceoInfo[index2].name,
                                'company': ceoInfo[index2].company,
                                'age': ceoInfo[index2].age,
                                'image': ceoImages[index2],
                              });
                              controller.triggerLeft();
                            },
                            child: AnimatedOpacity(
                              opacity: _visibleicons ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 3),
                              child: Icon(
                                Typicons.thumbs_down,
                                color: Colors.white70,
                                size: screenHeight * 0.03694,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.6,
                      ),
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _firestore
                                  .collection('upvotes')
                                  .document(ceoInfo[index2].id)
                                  .setData({
                                'name': ceoInfo[index2].name,
                                'company': ceoInfo[index2].company,
                                'age': ceoInfo[index2].age,
                                'image': ceoImages[index2],
                              });
                              controller.triggerRight();
                            },
                            child: AnimatedOpacity(
                              opacity: _visibleicons ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 3),
                              child: Icon(
                                Typicons.thumbs_up,
                                color: Colors.white70,
                                size: screenHeight * 0.03694,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  height: screenHeight * 0.11083,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(screenHeight * 0.03078),
                      topLeft: Radius.circular(screenHeight * 0.03078),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.03694),
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
        ],
      ),
    );
  }
}
