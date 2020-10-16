import 'package:flutter/material.dart';

class TextRounded extends StatelessWidget {
  const TextRounded({Key key, this.text, this.width = 80}) : super(key: key);
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Colors.grey[600]),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.w400))),
    );
  }
}
