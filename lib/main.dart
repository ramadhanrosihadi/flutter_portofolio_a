import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_b/common/constant/RoutePath.dart';
import 'package:flutter_starter_b/ui/auth/signin/signin_page.dart';
import 'package:flutter_starter_b/ui/auth/splash/splash_page.dart';
import 'package:flutter_starter_b/ui/dashboard/dashboard_page.dart';
import 'package:flutter_starter_b/ui/example/example_page.dart';
import 'package:firebase/firebase.dart' as fb;

import 'common/constant/VColor.dart';
import 'common/constant/Var.dart';
import 'common/util/Nav.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: VColor.colorPrimary.withOpacity(0.1),
    statusBarColor: Colors.white,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Var.appName,
      navigatorKey: Nav.navigatorKey,
      debugShowCheckedModeBanner: Var.isDebugMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      ),
      home: SplashPage(),
      routes: {
        RoutePath.signin: (context) => SigninPage(),
        RoutePath.splash: (context) => SplashPage(),
        RoutePath.dashboard: (context) => DashboardPage(),
      },
    );
  }
}
