import 'package:flutter/material.dart';
import 'package:test1/home.dart';
import 'package:test1/profile.dart';
import 'package:test1/activity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  MainMenu(this.signOut);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _SelectedTabIndex = 0;

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
    setState(() {
//      email = preferences.getString("email");
//      nama = preferences.getString("nama");
    });
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
      HomeScreen(),
      ActivityScreen(),
      ProfileScreen(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.list_sharp),
        title: Text('Activity'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('Profile'),
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
            title: Text("Main Menu"),
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
          // body: Center(
          //   child: Text("Dashboard"),
          // ),
          bottomNavigationBar: _bottomNavBar,
        ));
  }
}
