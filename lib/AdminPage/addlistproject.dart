import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController controllerKodeProject = new TextEditingController();
  TextEditingController controllerNamaProject = new TextEditingController();

  void AddData() {
    var url = "http://192.168.100.10/TimeReport/entryproject.php";

    http.post(url, body: {
      "kodeproject": controllerKodeProject.text,
      "namaproject": controllerNamaProject.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Entry Project"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerKodeProject,
                decoration: new InputDecoration(
                    hintText: "Kode Project",
                    labelText: "Kode Project",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0))),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new TextField(
                controller: controllerNamaProject,
                decoration: new InputDecoration(
                    hintText: "Nama Project",
                    labelText: "Nama Project",
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
