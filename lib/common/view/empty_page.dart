import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String text;
  final double height;

  const EmptyPage({Key key, this.text = "Belum ada data.", this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w300, fontStyle: FontStyle.italic, fontSize: 16),
        ),
      ),
    );
  }
}
