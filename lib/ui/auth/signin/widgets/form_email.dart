import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/util/Validator.dart';

class FormEmail extends StatelessWidget {
  FormEmail({Key key, this.controller, this.label = "Email"}) : super(key: key);
  final TextEditingController controller;
  String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: VColor.hintColor))),
      child: TextFormField(
        controller: controller,
        validator: Validator.isEmailValid,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          labelText: label,
          hintStyle: TextStyle(color: VColor.hintColor),
        ),
      ),
    );
  }
}
