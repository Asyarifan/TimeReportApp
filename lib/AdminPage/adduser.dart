import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/AdminPage/model/managerModel.dart';

import '../api.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String _manager;
  var loading = false;
  int _rolevalue = 0;
  //final list = new List<ManagerModel>();
  List<dynamic> _listManager = List();

  TextEditingController controllerNIK = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerRole = new TextEditingController();

  void AddData() async {
    // var url = "http://192.168.100.10/TimeReport/entryuser.php";

    // http.post(url, body: {
    //   "nik": controllerNIK.text,
    //   "name": controllerName.text,
    //   "email": controllerEmail.text,
    //   //"role": controllerRole.text,
    //   "role": _rolevalue.toString(),
    // });
    await http.post(BaseUrl.entryUser, body: {
      "nik": controllerNIK.text,
      "name": controllerName.text,
      "email": controllerEmail.text,
      "role": _rolevalue.toString(),
      "parentid": _manager
    });
  }

  Future<List> getmanager() async {
    final response = await http.get(BaseUrl.getListManager);
    var listData = json.decode(response.body);
    setState(() {
      _listManager = listData;
    });
  }

  @override
  void initState() {
    super.initState();
    getmanager();
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _rolevalue = value;

      switch (_rolevalue) {
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Entry User"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerNIK,
                decoration: new InputDecoration(
                    hintText: "NIK",
                    labelText: "NIK",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0))),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerName,
                decoration: new InputDecoration(
                    hintText: "Nama",
                    labelText: "Nama",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0))),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerEmail,
                decoration: new InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0))),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new Row(
                children: <Widget>[
                  new Text(
                    "Manager           ",
                    style: new TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                  new DropdownButton(
                    hint: Text("Choose Manager"),
                    value: _manager,
                    items: _listManager.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['name']),
                        value: item['id'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _manager = value;
                      });
                    },
                  ),
                ],
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Radio(
                    value: 1,
                    groupValue: _rolevalue,
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text(
                    'Admin',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: _rolevalue,
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text(
                    'Staff',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 3,
                    groupValue: _rolevalue,
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text(
                    'Manager',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              new RaisedButton(
                child: new Text("Add"),
                color: Colors.blueAccent,
                onPressed: () {
                  print(_rolevalue);
                  AddData();
                  //ActivityScreen();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }
}
