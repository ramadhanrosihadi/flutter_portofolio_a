import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/util/Validator.dart';

class FormText extends StatelessWidget {
  FormText({Key key, this.controller, this.label = "", this.icon, this.validator, this.textInputType = TextInputType.text, this.maxLine}) : super(key: key);
  final TextEditingController controller;
  String label;
  final IconData icon;
  final Function validator;
  final TextInputType textInputType;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (validator != null)
            ? validator
            : (value) {
                return Validator.isTextValid(value, label: label);
              },
        maxLines: maxLine,
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
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
