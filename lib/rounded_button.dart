import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String buttonTitle;
  final Function onPressed;
  final Color textColor;

  RoundedButton(
      {this.color, this.buttonTitle, this.textColor, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01231),
      child: Material(
        elevation: screenHeight * 0.00615,
        color: color,
        borderRadius: BorderRadius.circular(screenHeight * 0.03694),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: screenWidth * 0.8,
          height: screenHeight * 0.05172,
          child: Text(
            buttonTitle,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
