import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';

class TextInfo extends StatelessWidget {
  const TextInfo({Key key, this.label, this.value, this.alignment = Alignment.centerLeft}) : super(key: key);
  final String label;
  final String value;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: alignment,
          child: Text(
            Fun.replaceEmpty(label),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey[500]),
          ),
        ),
        Align(
          alignment: alignment,
          child: Text(
            Fun.replaceEmpty(value),
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.grey[500]),
          ),
        ),
      ],
    );
  }
}
