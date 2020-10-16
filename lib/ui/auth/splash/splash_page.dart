import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/constant/Var.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/ui/auth/signin/signin_page.dart';
import 'package:flutter_starter_b/ui/dashboard/dashboard_page.dart';
import 'package:flutter_starter_b/ui/portofolio/view/portofolio_main_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _visible = false;
  int durationAnimation = 1000;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: durationAnimation)).then((value) {
      Nav.push(context, PortofolioMainPage());
    });
  }

  void _setVisible(bool value) {
    setState(() {
      _visible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Center(
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0,
              duration: Duration(milliseconds: durationAnimation - 200),
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  ))),
            ),
          ),
        ),
      ),
    );
  }
}
