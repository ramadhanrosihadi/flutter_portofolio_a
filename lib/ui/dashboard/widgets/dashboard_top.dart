import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';

class DashboardTop extends StatefulWidget {
  const DashboardTop({Key key, this.text}) : super(key: key);

  @override
  _DashboardTopState createState() => _DashboardTopState();
  final String text;
}

class _DashboardTopState extends State<DashboardTop> {
  String currentVersion = "";
  @override
  void initState() {
    Fun.currentVersion().then((value) => setState(() {
          currentVersion = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 5.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                // Text(
                //   currentVersion,
                //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                // ),
                Expanded(
                  // child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Text(
                  //       widget.text,
                  //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  //     )),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      currentVersion,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
