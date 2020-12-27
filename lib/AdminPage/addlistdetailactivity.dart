import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TextEditingController controllerActivity = new TextEditingController();

  void AddData() {
    var url = "http://192.168.100.10/TimeReport/entryactivitylist.php";

    http.post(url, body: {
      "activity": controllerActivity.text,
    });
  }

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
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerActivity,
                decoration: new InputDecoration(
                    hintText: "Activity",
                    labelText: "Activity",
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
