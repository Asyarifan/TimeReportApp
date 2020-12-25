import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './listactivity.dart';

class EditActivity extends StatefulWidget {
  final List list;
  final int index;

  EditActivity({this.list, this.index});
  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  TextEditingController controllerProject = new TextEditingController();
  TextEditingController controllerActivity = new TextEditingController();
  TextEditingController controllerDate = new TextEditingController();
  TextEditingController controllerDuration = new TextEditingController();
  TextEditingController controllerRemark = new TextEditingController();

  void EditData() {
    var url = "http://192.168.100.10/TimeReport/editactivity.php";

    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "project": controllerProject.text,
      "activity": controllerActivity.text,
      "date": controllerDate.text,
      "time": controllerDuration.text,
      "remark": controllerRemark.text,
    });
  }

  @override
  void initState() {
    controllerProject =
        new TextEditingController(text: widget.list[widget.index]['project']);
    controllerActivity =
        new TextEditingController(text: widget.list[widget.index]['activity']);
    controllerDate =
        new TextEditingController(text: widget.list[widget.index]['date']);
    controllerDuration =
        new TextEditingController(text: widget.list[widget.index]['duration']);
    controllerRemark =
        new TextEditingController(text: widget.list[widget.index]['remark']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Activity"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerProject,
                  decoration: new InputDecoration(
                      hintText: "Project", labelText: "Project"),
                ),
                new TextField(
                  controller: controllerActivity,
                  decoration: new InputDecoration(
                      hintText: "Activity", labelText: "Activity"),
                ),
                new TextField(
                  controller: controllerDate,
                  decoration:
                      new InputDecoration(hintText: "Date", labelText: "Date"),
                ),
                new TextField(
                  controller: controllerDuration,
                  decoration: new InputDecoration(
                      hintText: "Duration", labelText: "Duration"),
                ),
                new TextField(
                  controller: controllerRemark,
                  decoration: new InputDecoration(
                      hintText: "Remark", labelText: "Remark"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Edit"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    EditData();
                    //ActivityScreen();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ActivityScreen()),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
