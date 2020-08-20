import 'package:flutter/material.dart';

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;
  SelectedPhoto({this.numberOfDots, this.photoIndex});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    Widget _inactivePhoto() {
      return Container(
        child: Padding(
          padding: EdgeInsets.only(
              left: screenHeight * 0.00369, right: screenHeight * 0.00369),
          child: Container(
            height: screenHeight * 0.00985,
            width: screenHeight * 0.00985,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(screenHeight * 0.00492),
            ),
          ),
        ),
      );
    }

    Widget _activePhoto() {
      return Container(
        child: Padding(
          padding: EdgeInsets.only(
              left: screenHeight * 0.00615, right: screenHeight * 0.00615),
          child: Container(
            height: screenHeight * 0.01231,
            width: screenHeight * 0.01231,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenHeight * 0.00615),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: screenHeight * 0.00246,
                  ),
                ]),
          ),
        ),
      );
    }

    List<Widget> _buildDots() {
      List<Widget> dots = [];
      for (int i = 0; i < numberOfDots; i++) {
        dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
      }
      return dots;
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
