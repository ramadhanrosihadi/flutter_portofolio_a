import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/util/Validator.dart';

class FormPhone extends StatelessWidget {
  FormPhone({Key key, this.controller, this.label = "Nomor HP", this.enabled = true}) : super(key: key);
  final TextEditingController controller;
  String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: Validator.isPhoneValid,
        keyboardType: TextInputType.phone,
        enabled: enabled,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_android_rounded),
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
