import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double height;
  final double width;
  final double fontSize;
  final Color firstColor;
  final Color lastColor;
  const ButtonPrimary({Key key, this.text, this.onPressed, this.height = 40, this.width = 180, this.fontSize = 14, this.firstColor, this.lastColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color tempFirstColor = firstColor;
    Color tempLastColor = lastColor;
    if (tempFirstColor == null) {
      tempFirstColor = Colors.blue[700];
    }
    if (tempLastColor == null) {
      tempLastColor = Colors.blue[400];
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            colors: [
              tempFirstColor,
              tempLastColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: FlatButton(
            onPressed: onPressed,
            child: Container(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: fontSize),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
