import 'package:flutter/cupertino.dart';

class Validator {
  static String isEmailValid(String value, {String label = "Email"}) {
    String result = isTextValid(value, label: label);
    if (result != null) {
      return result;
    } else {
      final _emailRegex = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
      if (!_emailRegex.hasMatch(value)) {
        return "Email tidak valid";
      }
    }
    return null;
  }

  static String isPhoneValid(String value, {String label = "Nomor HP"}) {
    String result = isTextValid(value, label: label);
    if (result != null) {
      return result;
    } else {
      final String _pattern = r'(^(?:[+0])?[0-9]{8,16}$)';
      final _phoneRegex = RegExp(_pattern);
      if (!_phoneRegex.hasMatch(value)) {
        return "Nomor HP tidak valid";
      }
    }
    return null;
  }

  static String isTextValid(
    String value, {
    String label = "",
    int minLength = 0,
    int maxLength = 1000,
  }) {
    if (value.isEmpty) {
      return "$label wajib diisi";
    } else if (value.length < minLength) {
      return "$label minimal $minLength karakter";
    } else if (value.length > maxLength) {
      return "$label maksimal $maxLength karakter";
    }
    return null;
  }
}
