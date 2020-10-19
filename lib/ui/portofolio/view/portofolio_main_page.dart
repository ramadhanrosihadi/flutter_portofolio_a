import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/model/firebase/firebase_state.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/constant/VString.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/view/comingsoon_view.dart';
import 'package:flutter_starter_b/common/view/empty_page.dart';
import 'package:flutter_starter_b/common/widget/custom_slider.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/ui/portofolio/model/Portofolio.dart';
import 'package:flutter_starter_b/ui/portofolio/view/portofolio_create_page.dart';
import 'package:flutter_starter_b/ui/portofolio/view/widgets/portofolio_item.dart';

class PortofolioMainPage extends StatefulWidget {
  PortofolioMainPage({Key key}) : super(key: key);

  @override
  _PortofolioMainPageState createState() => _PortofolioMainPageState();
}

class _PortofolioMainPageState extends State<PortofolioMainPage> {
  Portofolio model = Portofolio();
  @override
  void initState() {
    super.initState();
    model.fetch();
  }

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
                SizedBox(height: 20),
                StreamBuilder(
                  stream: model.state,
                  builder: (context, snapshot) {
                    if (snapshot.data is FirebaseState) {
                      Fun.log.wtf("snapshot.data is FirebaseState");
                      FirebaseState state = snapshot.data;
                      if (state.stateCode == StateCode.LOADING) {
                        return CircularProgressIndicator();
                      } else {
                        List<Portofolio> datas = state.data;
                        if (datas.length == 0) {
                          return EmptyPage(height: 500);
                        }
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Portofolio data = datas[index];
                            return PortofolioItem(portofolio: data);
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              color: Colors.grey[400],
                              height: 0.4,
                              margin: EdgeInsets.only(bottom: 20),
                            );
                          },
                          itemCount: datas.length,
                        );
                      }
                    } else {
                      Fun.log.wtf("snapshot.data not FirebaseState");
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Nav.push(context, PortofolioCreatePage());
          model.fetch();
        },
        backgroundColor: VColor.colorPrimary,
        child: Icon(Icons.add),
      ),
    );
  }
}
