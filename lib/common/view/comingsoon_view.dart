import 'package:flutter/material.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({Key key, this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            Text(
              'Coming Soon!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
