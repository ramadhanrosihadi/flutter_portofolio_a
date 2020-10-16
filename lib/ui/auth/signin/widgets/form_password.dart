import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/Validator.dart';

class FormPassword extends StatefulWidget {
  const FormPassword({
    Key key,
    this.controller,
    this.label = "Kata sandi",
    this.validator,
    this.textInputType = TextInputType.text,
    this.maxLength,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final Function validator;
  final TextInputType textInputType;
  final int maxLength;

  @override
  _FormPasswordState createState() => _FormPasswordState();
}

class _FormPasswordState extends State<FormPassword> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        validator: (widget.validator != null)
            ? widget.validator
            : (value) {
                return Validator.isTextValid(value, label: "Kata sandi");
              },
        obscureText: obscureText,
        keyboardType: widget.textInputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            child: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          ),
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          labelText: widget.label,
          hintText: widget.label,
          hintStyle: TextStyle(color: VColor.hintColor),
        ),
      ),
    );
  }
}
