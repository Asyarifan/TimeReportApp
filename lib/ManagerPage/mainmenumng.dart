import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/./profile.dart';
import 'package:test1/./home.dart';
import 'package:test1/ManagerPage/listActivityEmp.dart';
import 'package:test1/changepassword.dart';

class MainMenuManager extends StatefulWidget {
  final VoidCallback signOut;

  MainMenuManager(this.signOut);

  @override
  _MainMenuManagerState createState() => _MainMenuManagerState();
}

class _MainMenuManagerState extends State<MainMenuManager> {
  int _SelectedTabIndex = 0;
  String _iduser;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

//  String email = "", nama = "";
//  TabController tabController;
  var id;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    _iduser = id;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      HomeScreen(),
      ActivityEmpScreen(),
      ChangePasswordScreen()
      //ProfileScreen(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people_sharp),
        title: Text('Activity Team'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.create_outlined),
        title: Text('Change Password'),
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
            title: Text("Main Menu Manager"),
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
