import 'package:flutter/material.dart';

class Nav {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navAndRemoveUntil(String routeName, [String message]) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: message,
    );
  }

  static Future<dynamic> nav(String routeName, [Object arguments]) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  static Future<T> push<T extends Object>(BuildContext context, Widget widget) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static Future<T> pushReplacement<T extends Object>(BuildContext context, Widget widget) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
  }

  static Future<T> pushAndRemoveUntil<T extends Object>(BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget), (Route<dynamic> route) => false);
  }

  static void pop<T extends Object>(BuildContext context, [T result]) {
    Navigator.of(context).pop(result);
  }
}
