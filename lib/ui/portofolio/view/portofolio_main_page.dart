import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/VString.dart';
import 'package:flutter_starter_b/common/view/comingsoon_view.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';

class PortofolioMainPage extends StatefulWidget {
  PortofolioMainPage({Key key}) : super(key: key);

  @override
  _PortofolioMainPageState createState() => _PortofolioMainPageState();
}

class _PortofolioMainPageState extends State<PortofolioMainPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Portofolio",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[700],
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 2.5,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                          child: Image.asset('assets/images/mobile_design2.jpg'),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Insert title here...",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  VString.lorem_ipsum,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
