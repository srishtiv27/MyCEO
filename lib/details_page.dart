import 'package:flutter/material.dart';
import 'package:my_ceo/menu_page.dart';
import 'ceo.dart';
import 'selected_photo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({this.ceo});
  final Ceo ceo;
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  int photoIndex = 0;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    photoIndex = (photoIndex + 1) % widget.ceo.photos.length;
                  });
                },
                child: Container(
                  height: screenHeight * 0.7,
                  child: Hero(
                    tag: 'Ceo ${widget.ceo.id}',
                    child: Image.asset(
                      widget.ceo.photos[photoIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.00615,
                left: screenWidth * 0.02666,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                      left: screenHeight * 0.0197, top: screenHeight * 0.04926),
                  height: screenHeight * 0.5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MenuPage.id);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: screenHeight * 0.03,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.07389,
                left: screenWidth * 0.08,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ceo.name,
                      style: TextStyle(
                        color: Color(0xF2FFFFFF),
                        fontSize: screenHeight * 0.04310,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.00615,
                    ),
                    Text(
                      widget.ceo.company,
                      style: TextStyle(
                        color: Color(0xF2FFFFFF),
                        fontSize: screenHeight * 0.02463,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: screenWidth * 0.08,
                bottom: screenHeight * 0.04926,
                child: SelectedPhoto(
                  numberOfDots: widget.ceo.photos.length,
                  photoIndex: photoIndex,
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight * 0.03694,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.04926),
                    topRight: Radius.circular(screenHeight * 0.04926),
                  ),
                ),
              ),
              Positioned(
                right: screenWidth * 0.08,
                bottom: screenHeight * 0.01231,
                child: Container(
                  height: screenHeight * 0.06157,
                  width: screenWidth * 0.32,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(screenHeight * 0.03078),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.ceo.age,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.020935,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02463,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              controller: ScrollController(
                initialScrollOffset: screenHeight * 0.04926,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Text(
                    widget.ceo.bio,
                    style: TextStyle(
                      fontSize: screenHeight * 0.02019,
                      height: screenHeight * 0.001847,
                    ),
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
