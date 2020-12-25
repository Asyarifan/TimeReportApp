import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/home.dart';

class MainMenuAdmin extends StatefulWidget {
  final VoidCallback signOut;
  MainMenuAdmin(this.signOut);
  @override
  _MainMenuAdminState createState() => _MainMenuAdminState();
}

class _MainMenuAdminState extends State<MainMenuAdmin> {
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
      HomeScreen(),
      // ActivityScreen(),
      // ProfileScreen(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.list_sharp),
      //   title: Text('Activity'),
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.person),
      //   title: Text('Profile'),
      // ),
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
          bottomNavigationBar: _bottomNavBar,
        ));
  }
}
