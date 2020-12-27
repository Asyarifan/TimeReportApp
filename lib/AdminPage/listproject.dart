import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/AdminPage/addlistproject.dart';

class ListProjectScreen extends StatefulWidget {
  @override
  _ListProjectScreenState createState() => _ListProjectScreenState();
}

class _ListProjectScreenState extends State<ListProjectScreen> {
  Future<List> getdata() async {
    final response =
        await http.post("http://192.168.100.10/TimeReport/getdataproject.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddProject(),
        )),
      ),
      body: new FutureBuilder<List>(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new itemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class itemList extends StatelessWidget {
  List list;
  itemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Card(
            child: new ListTile(
              title: new Text(list[i]['namaproject']),
              leading: new Icon(Icons.list_sharp),
              subtitle: new Text(list[i]['kodeproject']),
            ),
          ),
        );
      },
    );
  }
}
