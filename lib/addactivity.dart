import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/listactivity.dart';
import 'package:test1/MyTextFieldDatePicker.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  String _project, _activity;
  DateTime _datePicked;
  List<dynamic> _listProject = List();
  List<dynamic> _listActivity = List();

  TextEditingController controllerProject = new TextEditingController();
  TextEditingController controllerActivity = new TextEditingController();
  TextEditingController controllerDate = new TextEditingController();
  TextEditingController controllerDuration = new TextEditingController();
  TextEditingController controllerRemark = new TextEditingController();

  void AddData() {
    var url = "http://192.168.100.10/TimeReport/entryactivity.php";

    http.post(url, body: {
      "project": _project,
      "activity": _activity,
      "date": controllerDate.text,
      "time": controllerDuration.text,
      "remark": controllerRemark.text,
    });
  }

  Future<List> getproject() async {
    final response =
        await http.get("http://192.168.100.10/TimeReport/getdataproject.php");
    var listData = json.decode(response.body);
    setState(() {
      _listProject = listData;
    });
  }

  Future<List> getactivitylist() async {
    final response =
        await http.get("http://192.168.100.10/TimeReport/getlistactivity.php");
    var listData = json.decode(response.body);
    setState(() {
      _listActivity = listData;
    });
  }

  @override
  void initState() {
    super.initState();
    getproject();
    getactivitylist();
  }

  // void _showDatePicker() {
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(2020),
  //           lastDate: DateTime.now())
  //       .then((value) {
  //     if (value == null) {
  //       return;
  //     }
  //     setState(() {
  //       _datePicked = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Add Activity"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    "Project           ",
                    style: new TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                  new DropdownButton(
                    hint: Text("Choose Project"),
                    value: _project,
                    items: _listProject.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['kodeproject']),
                        value: item['idproject'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _project = value;
                      });
                    },
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Text(
                    "Activity           ",
                    style: new TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                  new DropdownButton(
                    hint: Text("Choose Activity"),
                    value: _activity,
                    items: _listActivity.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['activity']),
                        value: item['id'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _activity = value;
                      });
                    },
                  ),
                ],
              ),
              // Container(
              //   height: 60,
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: Text(
              //           _datePicked == null
              //               ? 'Pilih tanggal'
              //               : 'Tanggal: ${DateFormat.yMd().format(_datePicked)}',
              //           style: TextStyle(color: Colors.black),
              //         ),
              //       ),
              //       FlatButton(
              //         child: Text(
              //           'Choose Date',
              //           style: TextStyle(fontWeight: FontWeight.bold),
              //         ),
              //         textColor: Theme.of(context).accentColor,
              //         onPressed: () => _showDatePicker(),
              //       ),
              //     ],
              //   ),
              // ),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              // MyTextFieldDatePicker(
              //   labelText: "Date",
              //   prefixIcon: Icon(Icons.date_range),
              //   suffixIcon: Icon(Icons.arrow_drop_down),
              //   lastDate: DateTime.now().add(Duration(days: 366)),
              //   firstDate: DateTime.now(),
              //   initialDate: DateTime.now().add(Duration(days: 1)),
              //   onDateChanged: (selectedDate) {
              //     _datePicked = selectedDate;
              //     // Do something with the selected date
              //   },
              // ),

              new TextField(
                controller: controllerDate,
                keyboardType: TextInputType.datetime,
                decoration: new InputDecoration(
                    hintText: "Date",
                    labelText: "Date",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0))),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerDuration,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    hintText: "Duration",
                    labelText: "Duration",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0))),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerRemark,
                decoration: new InputDecoration(
                    hintText: "Remark",
                    labelText: "Remark",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0))),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              new RaisedButton(
                child: new Text("Add"),
                color: Colors.blueAccent,
                onPressed: () {
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
