import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/AdminPage/listdetailactivity.dart';
import 'package:test1/home.dart';
import 'package:test1/profile.dart';
import 'package:test1/listactivity.dart';
import 'package:test1/AdminPage/listproject.dart';
import 'package:test1/AdminPage/listuser.dart';

class MainMenuAdmin extends StatefulWidget {
  final VoidCallback signOut;

  MainMenuAdmin(this.signOut);
  @override
  _MainMenuAdminState createState() => _MainMenuAdminState();
}

class _MainMenuAdminState extends State<MainMenuAdmin> {
  int _SelectedTabIndex = 0;
  String _role;
  void _onNavBarTapped(int index) {
    setState(() {
      _SelectedTabIndex = index;
    });
  }

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

//  String email = "", nama = "";
//  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _role = preferences.getString("role");
    print("Main Menu Admin");
    print(_role);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      //HomeScreen(),
      //ActivityScreen(),
      ListProjectScreen(),
      ListDetailActivityScreen(),
      ListUserScreen()
      //ProfileScreen(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.home),
      //   title: Text('Home'),
      // ),
      BottomNavigationBarItem(
        icon: Icon(Icons.list_sharp),
        title: Text('Project'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment_outlined),
        title: Text('Activity'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('User'),
      ),
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _SelectedTabIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onNavBarTapped,
    );

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Main Menu Admin"),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(Icons.lock_open),
              )
            ],
          ),
          body: Center(child: _listPage[_SelectedTabIndex]),
          bottomNavigationBar: _bottomNavBar,
        ));
  }
}
