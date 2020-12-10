import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailActivity extends StatefulWidget {
  List list;
  int index;
  DetailActivity({this.index, this.list});
  @override
  _DetailActivityState createState() => new _DetailActivityState();
}

class _DetailActivityState extends State<DetailActivity> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("${widget.list[widget.index]['project']}")),
      body: new Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                new Text(
                  widget.list[widget.index]['project'],
                  style: new TextStyle(fontSize: 30.0),
                ),
                new Text("Activity: ${widget.list[widget.index]['activity']}",
                    style: new TextStyle(fontSize: 20.0)),
                new Text("Date: ${widget.list[widget.index]['date']}",
                    style: new TextStyle(fontSize: 18.0)),
                new Text("Duration: ${widget.list[widget.index]['time']}",
                    style: new TextStyle(fontSize: 15.0)),
                new Text("Remarks: ${widget.list[widget.index]['remark']}",
                    style: new TextStyle(fontSize: 15.0)),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.green,
                      onPressed: () {},
                    ),
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.green,
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
