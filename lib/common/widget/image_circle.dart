import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  const ImageCircle({Key key, this.child, this.size}) : super(key: key);
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        border: Border.all(color: Colors.grey[500]),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: child,
      ),
    );
  }
}
