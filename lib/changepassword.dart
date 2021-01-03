import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/api.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _iduser;

  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerRePassword = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  var id;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    _iduser = id;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  void alertDialog() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
        "Are You Sure?",
        style: new TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        new RaisedButton(
          color: Colors.blue,
          child: new Text("Yes"),
          onPressed: () {
            savePassword();
            Navigator.pop(context);
          },
        ),
        new RaisedButton(
          color: Colors.blue,
          child: new Text("No"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  void validation() {
    String validatePassword = "Password doesn't match";
    String validatePassword1 = "Password cannot be null";

    if (controllerPassword.text.isEmpty) {
      _scaffoldState.currentState.showSnackBar(new SnackBar(
        content: new Text(
          validatePassword1,
          style: new TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        duration: new Duration(seconds: 3),
      ));
    } else if (controllerPassword.text != controllerRePassword.text) {
      _scaffoldState.currentState.showSnackBar(new SnackBar(
        content: new Text(
          validatePassword,
          style: new TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        duration: new Duration(seconds: 3),
      ));
    } else {
      alertDialog();
    }
  }

  void savePassword() async {
    //print(controllerPassword.text);
    await http.post(BaseUrl.changePassword, body: {
      "id": _iduser,
      "password": controllerPassword.text,
    });
    controllerPassword.text = "";
    controllerRePassword.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: controllerPassword,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0))),
            ),
            new Padding(padding: new EdgeInsets.only(top: 20.0)),
            new TextField(
              controller: controllerRePassword,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  hintText: "Re-type Password",
                  labelText: "Re-type Password",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0))),
            ),
            new Padding(padding: new EdgeInsets.only(top: 20.0)),
            SizedBox(width: 10),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                validation();
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Change Password".toUpperCase(),
                  style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
