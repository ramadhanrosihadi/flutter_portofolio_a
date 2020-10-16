import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/RoutePath.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/data/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static Future<User> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson());
    prefs.setString('username', user.phone);
    return User.fromJson(prefs.getString('user'));
  }

  static Future<User> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = User.fromJson(prefs.getString('user'));
    return user;
  }

  static Future<String> loadTokenFirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token_firebase');
  }

  static Future<bool> saveTokenFirebase(String tokenFirebase) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token_firebase', tokenFirebase);
  }

  static Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = User.fromJson(prefs.getString('user'));
    if (user != null && user.id != null) {
      return true;
    }
    return false;
  }

  static clear([BuildContext context]) async {
    if (context != null) {
      // await VFirebase.signOutGoogle(context);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('gunakan_pin');
  }

  static signout([BuildContext context]) async {
    clear(context);
    Nav.navAndRemoveUntil(
      RoutePath.signin,
      "Sesi telah berakhir. Silahkan login kembali.",
    );
  }

  static Future<String> loadLastUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<bool> loadGunakanPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('gunakan_pin');
  }

  static Future<bool> saveGunakanPin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('gunakan_pin', value);
  }
}
