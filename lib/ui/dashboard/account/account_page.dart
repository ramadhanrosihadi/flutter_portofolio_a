import 'package:flutter/material.dart';
import 'package:flutter_starter_b/api/DataRequest.dart';
import 'package:flutter_starter_b/api/Urls.dart';
import 'package:flutter_starter_b/api/model/api_event.dart';
import 'package:flutter_starter_b/api/model/api_model.dart';
import 'package:flutter_starter_b/api/model/api_state.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/view/comingsoon_view.dart';
import 'package:flutter_starter_b/data/User.dart';
import 'package:flutter_starter_b/ui/dashboard/widgets/dashboard_top.dart';
import 'package:flutter_starter_b/ui/profile/edit/profile_edit_page.dart';
import 'package:flutter_starter_b/ui/profile/setting_pin/pin_change_page.dart';
import 'package:flutter_starter_b/ui/profile/ubah_password/ubah_password_page.dart';

import 'widgets/item_account_menu.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User currentUser = User();
  final ApiModel apiModel = ApiModel();

  @override
  void initState() {
    syncUserInfo();
    super.initState();
    apiModel.apiState.forEach((element) {
      if (element is SuccessState || element is ErrorState) {
        UserPref.signout(context);
      }
    });
  }

  void syncUserInfo() {
    UserPref.loadUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardTop(
          text: "Account",
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      "Hi, ${currentUser.name}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                ItemAccountMenu(
                  title: "Edit Profile",
                  iconData: Icons.person,
                  onPressed: () async {
                    Nav.push(context, ProfileEditPage()).then((value) {
                      if (value != null && value) {
                        syncUserInfo();
                      }
                    });
                  },
                ),
                ItemAccountMenu(
                  title: "Ubah Kata Sandi",
                  iconData: Icons.lock_open,
                  onPressed: () {
                    Nav.push(context, UbahPasswordPage());
                  },
                ),
                ItemAccountMenu(
                  title: "Setting PIN",
                  iconData: Icons.vpn_key,
                  onPressed: () {
                    Nav.push(context, PinChangePage());
                  },
                ),
                StreamBuilder(
                  stream: apiModel.apiState,
                  builder: (context, snapshot) {
                    if (snapshot.data is LoadingState) {
                      return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ItemAccountMenu(
                        title: "Keluar",
                        iconData: Icons.exit_to_app,
                        onPressed: () {
                          DataRequest dataRequest = DataRequest(url: Urls.autentikasi_signout);
                          apiModel.dispose(CallApi(dataRequest));
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
