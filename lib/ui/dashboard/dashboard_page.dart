import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/constant/VString.dart';
import 'package:flutter_starter_b/common/constant/Var.dart';
import 'package:flutter_starter_b/common/pref/UserPref.dart';
import 'package:flutter_starter_b/common/view/comingsoon_view.dart';
import 'package:flutter_starter_b/data/User.dart';
import 'package:flutter_starter_b/ui/dashboard/account/account_page.dart';
import 'package:flutter_starter_b/ui/dashboard/history/history_page.dart';
import 'package:flutter_starter_b/ui/dashboard/main/main_page.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  User currentUser;
  List<Widget> pages = [
    ComingSoonView(text: VString.please_wait),
    ComingSoonView(text: VString.please_wait),
    ComingSoonView(text: VString.please_wait),
  ];
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
  ];
  int _selectedTabIndex = 0;
  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    setPages();
    super.initState();
  }

  void setPages() async {
    currentUser = await UserPref.loadUser();
    String role = currentUser.getRole();
    List<Widget> newPages = [];
    List<BottomNavigationBarItem> newBottomNavBarItems = [];
    if (role == "admin") {
      newPages.add(ComingSoonView(text: "Menu Admin"));
      newBottomNavBarItems.add(BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"));

      newPages.add(HistoryPage());
      newBottomNavBarItems.add(BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"));

      newPages.add(AccountPage());
      newBottomNavBarItems.add(BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"));
    } else {
      newPages.add(MainPage());
      newBottomNavBarItems.add(BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"));

      newPages.add(HistoryPage());
      newBottomNavBarItems.add(BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"));

      newPages.add(AccountPage());
      newBottomNavBarItems.add(BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"));
    }
    setState(() {
      pages = newPages;
      bottomNavBarItems = newBottomNavBarItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _bottomNavBar = BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: VColor.colorPrimary,
      unselectedItemColor: Colors.grey[600],
      onTap: _onNavBarTapped,
      backgroundColor: Colors.white,
      elevation: 7,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_selectedTabIndex == 0) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Konfirmasi"),
                      content: Text("Apakah kamu ingin menutup aplikasi ${Var.appName}?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Kembali"),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text("Iya"),
                          onPressed: () async {
                            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                          },
                        ),
                      ],
                    );
                  });
            } else {
              setState(() {
                _selectedTabIndex = 0;
              });
            }
          },
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: pages[_selectedTabIndex],
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.white),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    )
                  ],
                ),
                child: _bottomNavBar,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
