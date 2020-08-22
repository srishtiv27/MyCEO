import 'package:flutter/material.dart';

class CeoCard extends StatelessWidget {
  CeoCard({
    this.screenHeight,
    this.deviceWidth,
    this.company,
    this.ceoName,
    this.age,
    this.image,
    this.id,
  });
  final double screenHeight;
  final double deviceWidth;
  final String ceoName;
  final String company;
  final String age;
  final String image;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenHeight * 0.01231,
        right: screenHeight * 0.02463,
        left: screenHeight * 0.02463,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Material(
            color: Color(0xFF112B4C),
            borderRadius: BorderRadius.circular(screenHeight * 0.02463),
            elevation: screenHeight * 0.00492,
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.02463),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: screenHeight * 0.17241,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ceoName,
                          style: TextStyle(
                            fontSize: screenHeight * 0.02586,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.00369,
                        ),
                        Text(
                          company,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          age,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.23399,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(screenHeight * 0.02463),
                child: Image(
                  image: AssetImage(image),
                  height: screenHeight * 0.20935,
                  fit: BoxFit.cover,
                  width: deviceWidth * 0.35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
